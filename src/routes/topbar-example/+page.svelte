<script lang="ts">
  import { Topbar } from '$lib/components/ui/topbar';
</script>

<svelte:head>
  <title>Topbar Example</title>
  <meta name="description" content="Example page for the Topbar component" />
</svelte:head>

<div class="flex flex-col min-h-screen">
  <Topbar showSearch={true} />

  <main class="flex-1 p-8 bg-muted/30">
    <div class="container mx-auto">
      <h1 class="text-3xl font-bold mb-6 text-foreground">Topbar Example Page</h1>
      <p class="text-lg text-muted-foreground mb-4">
        This page demonstrates the Topbar component with the search bar enabled.
      </p>
      <div class="bg-background p-6 rounded-lg shadow border border-border">
        <h2 class="text-xl font-semibold mb-3 text-foreground">Page Content Section</h2>
        <p class="text-foreground/90 mb-2">
          Scroll down to see how the Topbar remains fixed (if that's its intended behavior, though current Topbar is not sticky by default).
          The content below is just placeholder text to fill the page.
        </p>
        <div class="space-y-4 mt-4">
          {#each Array(20) as _, i}
            <p class="text-sm text-foreground/80">
              Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut
              labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco
              laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in
              voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat
              cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. (Item {i + 1})
            </p>
          {/each}
        </div>
      </div>
    </div>
  </main>

  <footer class="p-4 text-center text-sm text-muted-foreground border-t border-border">
    Topbar Example Footer &copy; {new Date().getFullYear()}
  </footer>
</div>

<style>
  /* Basic app-wide styles if not already present elsewhere, or for page-specific tweaks */
  /* Ensure body and html take full height for sticky footer if that was the goal */
  /* For this example, min-h-screen on the main div is enough */
</style>
