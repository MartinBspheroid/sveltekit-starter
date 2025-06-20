<script lang="ts">
	import {
		Search,
		Menu,
		User,
		Settings,
		LogOut,
		Command,
		Bell,
		Home,
		BarChart3,
		Users,
		FileText,
		HelpCircle
	} from 'lucide-svelte';
	// import a from "next/link"

	import { Avatar, AvatarFallback, AvatarImage } from '$lib/components/ui/avatar';
	import { Button } from '$lib/components/ui/button';
	import * as DropdownMenu from '$lib/components/ui/dropdown-menu';
	import { Sheet, SheetContent, SheetTrigger } from '$lib/components/ui/sheet';
	import {
		CommandDialog,
		CommandEmpty,
		CommandGroup,
		CommandInput,
		CommandItem,
		CommandList
	} from '$lib/components/ui/command';
	import { on } from 'svelte/events';
	import { onMount } from 'svelte';

	const navigationItems = [
		{ name: 'Dashboard', href: '/dashboard', icon: Home },
		{ name: 'Analytics', href: '/analytics', icon: BarChart3 },
		{ name: 'Users', href: '/users', icon: Users },
		{ name: 'Reports', href: '/reports', icon: FileText },
		{ name: 'Help', href: '/help', icon: HelpCircle }
	];

	// const [isSearchOpen, setIsSearchOpen] = useState(false)
	// const [isMobileMenuOpen, setIsMobileMenuOpen] = useState(false)
	let SearchOpen = $state(false);
	let MobileMenuOpen = $state(false);
	// Handle keyboard shortcut for search
	// useEffect(() => {

	//   document.addEventListener("keydown", handleKeyDown)
	//   return () => document.removeEventListener("keydown", handleKeyDown)
	// }, [])

	const handleKeyDown = (e: KeyboardEvent) => {
		if ((e.metaKey || e.ctrlKey) && e.key === 'k') {
			e.preventDefault();
			SearchOpen = true;
		}
	};

	onMount(() => {
		document.addEventListener('keydown', handleKeyDown);
		return () => document.removeEventListener('keydown', handleKeyDown);
	});
</script>

<svelte:head>
	<title>Topbar Example</title>
	<meta name="description" content="Example page for the Topbar component" />
</svelte:head>

<header
	class="bg-background/95 supports-[backdrop-filter]:bg-background/60 sticky top-0 z-50 w-full border-b backdrop-blur"
>
	<div class="container flex h-16 items-center justify-between px-4">
		<!-- {/* Logo */} -->
		<div class="flex items-center space-x-4">
			<a href="/" class="flex items-center space-x-2">
				<div class="bg-primary flex h-8 w-8 items-center justify-center rounded-lg">
					<span class="text-primary-foreground text-sm font-bold">A</span>
				</div>
				<span class="hidden text-xl font-bold sm:inline-block">AppName</span>
			</a>
		</div>

		<!-- {/* Desktop Navigation */} -->
		<nav class="hidden items-center space-x-6 md:flex">
			{#each navigationItems as item}
				<a
					href={item.href}
					class="hover:text-primary flex items-center space-x-1 text-sm font-medium transition-colors"
				>
					<item.icon class="h-4 w-4" />
					<span>{item.name}</span>
				</a>
			{/each}
		</nav>

		<!-- {/* Search and User Actions */} -->
		<div class="flex items-center space-x-4">
			<!-- {/* Desktop Search */} -->
			<div class="hidden md:block">
				<Button
					variant="outline"
					class="text-muted-foreground relative w-64 justify-start text-sm"
					onclick={() => (SearchOpen = true)}
				>
					<Search class="mr-2 h-4 w-4" />
					Search...
					<kbd
						class="bg-muted text-muted-foreground pointer-events-none absolute top-2 right-2 hidden h-5 items-center gap-1 rounded px-1.5 font-mono text-xs font-medium opacity-100 select-none sm:inline-flex"
					>
						<Command class="h-3 w-3" />K
					</kbd>
				</Button>
			</div>

			<!-- {/* Mobile Search Button */} -->
			<Button
				variant="ghost"
				size="icon"
				class="md:hidden"
				onclick={() => (SearchOpen = true)}
				aria-label="Search"
			>
				<Search class="h-5 w-5" />
			</Button>

			<!-- {/* Notifications */} -->
			<Button variant="ghost" size="icon" aria-label="Notifications">
				<Bell class="h-5 w-5" />
			</Button>

			<!-- {/* User Avatar Dropdown */} -->
			<DropdownMenu.Root>
				<DropdownMenu.Trigger>
					<Button variant="ghost" class="relative h-8 w-8 rounded-full">
						<Avatar class="h-8 w-8">
							<AvatarImage src="/placeholder.svg?height=32&width=32" alt="User avatar" />
							<AvatarFallback>JD</AvatarFallback>
						</Avatar>
					</Button>
				</DropdownMenu.Trigger>
				<DropdownMenu.Content class="w-56" align="end" forceMount>
					<DropdownMenu.Label class="font-normal">
						<div class="flex flex-col space-y-1">
							<p class="text-sm leading-none font-medium">John Doe</p>
							<p class="text-muted-foreground text-xs leading-none">john.doe@example.com</p>
						</div>
					</DropdownMenu.Label>
					<DropdownMenu.Separator />
					<DropdownMenu.Item>
						<a href="/profile" class="flex items-center">
							<User class="mr-2 h-4 w-4" />
							<span>Profile</span>
						</a>
					</DropdownMenu.Item>
					<DropdownMenu.Item>
						<a href="/settings" class="flex items-center">
							<Settings class="mr-2 h-4 w-4" />
							<span>Settings</span>
						</a>
					</DropdownMenu.Item>
					<DropdownMenu.Separator />
					<DropdownMenu.Item class="text-red-600 focus:text-red-600">
						<LogOut class="mr-2 h-4 w-4" />
						<span>Log out</span>
					</DropdownMenu.Item>
				</DropdownMenu.Content>
			</DropdownMenu.Root>

			<!-- {/* Mobile Menu Button */} -->
			<Sheet open={MobileMenuOpen} onOpenChange={(open) => (MobileMenuOpen = open)}>
				<SheetTrigger>
					<Button variant="ghost" size="icon" class="md:hidden" aria-label="Menu">
						<Menu class="h-5 w-5" />
					</Button>
				</SheetTrigger>
				<SheetContent side="right" class="w-[300px] sm:w-[400px]">
					<nav class="flex flex-col space-y-4">
						<div class="flex items-center space-x-2 pb-4">
							<div class="bg-primary flex h-8 w-8 items-center justify-center rounded-lg">
								<span class="text-primary-foreground text-sm font-bold">A</span>
							</div>
							<span class="text-xl font-bold">AppName</span>
						</div>
						{#each navigationItems as item}
							<a
								href={item.href}
								class="hover:text-primary flex items-center space-x-2 text-lg font-medium transition-colors"
								onclick={() => (MobileMenuOpen = false)}
							>
								<item.icon class="h-5 w-5" />
								<span>{item.name}</span>
							</a>
						{/each}
					</nav>
				</SheetContent>
			</Sheet>
		</div>
	</div>
</header>

<!-- {/* Command Dialog for Search */} -->
<CommandDialog open={SearchOpen} onOpenChange={(open) => (SearchOpen = open)}>
	<CommandInput placeholder="Type to search..." />
	<CommandList>
		<CommandEmpty>No results found.</CommandEmpty>
		<CommandGroup heading="Navigation">
			{#each navigationItems as item}
				<CommandItem
					onSelect={() => {
						SearchOpen = false;
						// Navigate to the selected item
						window.location.href = item.href;
					}}
				>
					<item.icon class="mr-2 h-4 w-4" />
					<span>{item.name}</span>
				</CommandItem>
			{/each}
		</CommandGroup>
		<CommandGroup heading="Quick Actions">
			<CommandItem onSelect={() => (SearchOpen = false)}>
				<User class="mr-2 h-4 w-4" />
				<span>View Profile</span>
			</CommandItem>
			<CommandItem onSelect={() => (SearchOpen = false)}>
				<Settings class="mr-2 h-4 w-4" />
				<span>Settings</span>
			</CommandItem>
		</CommandGroup>
	</CommandList>
</CommandDialog>
