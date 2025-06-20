import { render, screen, act } from '@testing-library/svelte';
import userEvent from '@testing-library/user-event';
import { Topbar } from '$lib/components/ui/topbar'; // Uses index.ts
import { writable, type Writable } from 'svelte/store';
import { vi } from 'vitest';

// Mock the isMobile hook. This is crucial.
// We create a writable store that our tests can control.
const mockIsMobileValueStore: Writable<boolean> = writable(false);

vi.mock('$lib/hooks/is-mobile.svelte.ts', () => {
  // This class mimics the structure of the actual IsMobile class
  class MockIsMobile {
    public value: Writable<boolean>;
    public subscribe;
    public set;

    constructor() {
      this.value = mockIsMobileValueStore; // Use the controllable store
      this.subscribe = this.value.subscribe;
      this.set = this.value.set;
    }
  }
  return { IsMobile: MockIsMobile };
});

// Helper function to set the mocked isMobile value
async function setIsMobile(isMobile: boolean) {
  mockIsMobileValueStore.set(isMobile);
  await act(); // Ensure Svelte reacts to the store change
}

describe('Topbar Component', () => {
  beforeEach(async () => {
    // Reset to default (desktop) before each test
    await setIsMobile(false);
  });

  test('renders without crashing', () => {
    const { container } = render(Topbar);
    expect(container).toBeInTheDocument();
  });

  describe('Desktop Navigation', () => {
    test('renders desktop navigation menu when not mobile', async () => {
      await setIsMobile(false);
      render(Topbar);
      expect(screen.getByText('Item One')).toBeInTheDocument();
      expect(screen.getByText('Item Two')).toBeInTheDocument();
      // Hamburger menu button should not be present
      expect(screen.queryByRole('button', { name: /menu/i })).not.toBeInTheDocument(); // More generic check for hamburger
    });

    test('desktop navigation links are present and content appears on click', async () => {
      await setIsMobile(false);
      render(Topbar);
      const user = userEvent.setup();

      const itemOneTrigger = screen.getByText('Item One');
      expect(itemOneTrigger).toBeInTheDocument();
      await user.click(itemOneTrigger);
      expect(await screen.findByText('Link A')).toBeInTheDocument();
      expect(await screen.findByText('Link B')).toBeInTheDocument();

      // Close Item One, Open Item Two
      await user.click(itemOneTrigger); // Close
      const itemTwoTrigger = screen.getByText('Item Two');
      await user.click(itemTwoTrigger); // Open
      expect(await screen.findByText('Link C')).toBeInTheDocument();
      expect(await screen.findByText('Link D')).toBeInTheDocument();
    });
  });

  describe('Mobile Navigation', () => {
    test('renders hamburger menu button when mobile', async () => {
      await setIsMobile(true);
      render(Topbar);
      // For mobile, the hamburger button should be visible
      // The button is inside SheetTrigger, which might not have a direct accessible name by default.
      // Let's look for the MenuIcon if the button itself is hard to select.
      // The Button component in Topbar uses variant="ghost" and size="icon" and contains MenuIcon.
      // A more robust way is to add an aria-label to the Button in topbar.svelte for the SheetTrigger.
      // e.g. <Button aria-label="Open navigation menu" ... >
      // For now, we assume it's the only button with "menu icon" visual
      const mobileMenuButton = screen.getByRole('button'); // This might be too generic if other buttons exist
      expect(mobileMenuButton).toBeInTheDocument();
      // Desktop navigation items should not be directly visible
      expect(screen.queryByText('Item One')).not.toBeInTheDocument();
    });

    test('clicking hamburger menu opens SheetContent with mobile links', async () => {
      await setIsMobile(true);
      render(Topbar);
      const user = userEvent.setup();

      // Assuming the SheetTrigger button is the primary button rendered in mobile view.
      // Add an aria-label="Open menu" to the mobile <Button> in topbar.svelte for a better selector.
      // For now, let's assume it's the first button or has a menu icon.
      const mobileMenuButton = screen.getByRole('button'); // Needs to be specific
      await user.click(mobileMenuButton);

      // SheetContent and its elements should become visible
      expect(await screen.findByText('Menu')).toBeInTheDocument(); // SheetTitle
      expect(await screen.findByText('Select a page to navigate to.')).toBeInTheDocument(); // SheetDescription
      expect(await screen.findByText('Item One - Link A')).toBeInTheDocument();
      expect(await screen.findByText('Item One - Link B')).toBeInTheDocument();
      expect(await screen.findByText('Item Two - Link C')).toBeInTheDocument();
      expect(await screen.findByText('Item Two - Link D')).toBeInTheDocument();
    });
  });

  describe('Search Bar', () => {
    test('renders search bar when showSearch is true', async () => {
      await setIsMobile(false); // Test on desktop for clarity, though it applies to mobile too
      render(Topbar, { props: { showSearch: true } });
      expect(screen.getByPlaceholderText('Type a command or search...')).toBeInTheDocument();
    });

    test('does not render search bar when showSearch is false', async () => {
      await setIsMobile(false);
      render(Topbar, { props: { showSearch: false } });
      expect(screen.queryByPlaceholderText('Type a command or search...')).not.toBeInTheDocument();
    });

    test('search bar is functional with items', async () => {
      await setIsMobile(false);
      render(Topbar, { props: { showSearch: true } });
      const user = userEvent.setup();
      const searchInput = screen.getByPlaceholderText('Type a command or search...');

      await user.click(searchInput); // Focus to show list if it's like a CommandDialog
      // Or type to filter
      expect(await screen.findByText('Suggestions')).toBeInTheDocument();
      expect(await screen.findByText('Calendar')).toBeInTheDocument();
      expect(await screen.findByText('Search Emoji')).toBeInTheDocument();
      expect(await screen.findByText('Calculator')).toBeInTheDocument();

      await user.type(searchInput, 'Cal');
      expect(screen.getByText('Calendar')).toBeInTheDocument();
      expect(screen.queryByText('Search Emoji')).not.toBeInTheDocument(); // Assuming it filters out
    });
  });
});
