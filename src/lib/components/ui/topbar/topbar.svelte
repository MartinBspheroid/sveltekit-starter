<script lang="ts">
  import {
    NavigationMenuRoot,
    NavigationMenuContent,
    NavigationMenuItem,
    NavigationMenuLink,
    NavigationMenuList,
    NavigationMenuTrigger,
  } from '$lib/components/ui/navigation-menu';
  import {
    Sheet,
    SheetTrigger,
    SheetContent,
    SheetHeader,
    SheetTitle,
    SheetDescription,
  } from '$lib/components/ui/sheet';
  import { IsMobile } from '$lib/hooks/is-mobile.svelte';
  import  Menu from 'lucide-svelte/icons/menu';
  import Button from '$lib/components/ui/button/button.svelte';
  import {
    Command,
    CommandInput,
    CommandList,
    CommandEmpty,
    CommandGroup,
    CommandItem,
  } from '$lib/components/ui/command';

  export let showSearch = false;

  const isMobile = new IsMobile();
</script>

<div class="flex items-center justify-between p-4 bg-background border-b h-16"> 
  <!-- {/* Main Topbar container styling */} -->
  <div class="flex items-center">
     <!-- {/* Navigation Area (Left) */} -->
    {#if isMobile.current}
      <Sheet>
        <SheetTrigger>
          <!-- {/* Mobile Navigation Trigger: Styled Button */} -->
          <Button  variant="ghost" size="icon" class="mr-2 text-foreground hover:bg-muted">
            <Menu class="h-6 w-6" />
          </Button>
        </SheetTrigger>
        <!-- {/* Mobile Navigation Panel: Styled SheetContent */} -->
        <SheetContent side="left" class="bg-background p-6">
          <SheetHeader class="mb-4">
            <SheetTitle class="text-lg font-semibold text-foreground">Menu</SheetTitle>
            <SheetDescription class="text-sm text-muted-foreground">
              Select a page to navigate to.
            </SheetDescription>
          </SheetHeader>
          <div class="flex flex-col space-y-3">
            <!-- {/* Styled Mobile Navigation Links */} -->
            <a href="/" class="text-base text-foreground hover:text-primary hover:underline underline-offset-2">Item One - Link A</a>
            <a href="/" class="text-base text-foreground hover:text-primary hover:underline underline-offset-2">Item One - Link B</a>
            <a href="/" class="text-base text-foreground hover:text-primary hover:underline underline-offset-2">Item Two - Link C</a>
            <a href="/" class="text-base text-foreground hover:text-primary hover:underline underline-offset-2">Item Two - Link D</a>
          </div>
        </SheetContent>
      </Sheet>
    {:else}
      <!-- {/* Desktop Navigation: Styled NavigationMenu */} -->
      <NavigationMenuRoot>
        <NavigationMenuList class="space-x-1">
          <NavigationMenuItem>
            <NavigationMenuTrigger class="text-sm font-medium text-foreground hover:bg-accent hover:text-accent-foreground focus:bg-accent focus:text-accent-foreground data-[active]:bg-accent/50 data-[state=open]:bg-accent/50 px-3 py-2 rounded-md">
              Item One
            </NavigationMenuTrigger>
            <NavigationMenuContent class="bg-background border border-border shadow-lg rounded-md p-2">
              <ul class="grid gap-1 md:w-[200px]">
                <li><NavigationMenuLink href="/" class="block select-none space-y-1 rounded-md p-3 leading-none no-underline outline-none transition-colors hover:bg-accent hover:text-accent-foreground focus:bg-accent focus:text-accent-foreground">Link A</NavigationMenuLink></li>
                <li><NavigationMenuLink href="/" class="block select-none space-y-1 rounded-md p-3 leading-none no-underline outline-none transition-colors hover:bg-accent hover:text-accent-foreground focus:bg-accent focus:text-accent-foreground">Link B</NavigationMenuLink></li>
              </ul>
            </NavigationMenuContent>
          </NavigationMenuItem>
          <NavigationMenuItem>
            <NavigationMenuTrigger class="text-sm font-medium text-foreground hover:bg-accent hover:text-accent-foreground focus:bg-accent focus:text-accent-foreground data-[active]:bg-accent/50 data-[state=open]:bg-accent/50 px-3 py-2 rounded-md">
              Item Two
            </NavigationMenuTrigger>
            <NavigationMenuContent class="bg-background border border-border shadow-lg rounded-md p-2">
              <ul class="grid gap-1 md:w-[200px]">
                <li><NavigationMenuLink href="/" class="block select-none space-y-1 rounded-md p-3 leading-none no-underline outline-none transition-colors hover:bg-accent hover:text-accent-foreground focus:bg-accent focus:text-accent-foreground">Link C</NavigationMenuLink></li>
                <li><NavigationMenuLink href="/" class="block select-none space-y-1 rounded-md p-3 leading-none no-underline outline-none transition-colors hover:bg-accent hover:text-accent-foreground focus:bg-accent focus:text-accent-foreground">Link D</NavigationMenuLink></li>
              </ul>
            </NavigationMenuContent>
          </NavigationMenuItem>
        </NavigationMenuList>
      </NavigationMenuRoot>
    {/if}
  </div>

  {#if showSearch}
  <!-- {/* Search Bar Area (Center) */} -->
   
    <div class="flex-1 flex justify-center px-4">
   <!-- {/* Styled Search Bar (Command) */}    -->
      <Command class="rounded-lg border border-border shadow-sm w-full max-w-xs sm:max-w-sm md:max-w-md bg-background text-foreground">
        <CommandInput placeholder="Type a command or search..." class="h-9 text-sm border-0 focus:ring-0 placeholder:text-muted-foreground" />
        <CommandList class="max-h-[300px] overflow-y-auto overflow-x-hidden">
          <CommandEmpty class="py-6 text-center text-sm text-muted-foreground">No results found.</CommandEmpty>
          <CommandGroup heading="Suggestions" class="text-xs text-muted-foreground px-2 py-1.5">
            <CommandItem class="text-sm text-foreground rounded-sm cursor-pointer select-none px-2 py-1.5 hover:bg-accent hover:text-accent-foreground data-[selected=true]:bg-accent data-[selected=true]:text-accent-foreground">Calendar</CommandItem>
            <CommandItem class="text-sm text-foreground rounded-sm cursor-pointer select-none px-2 py-1.5 hover:bg-accent hover:text-accent-foreground data-[selected=true]:bg-accent data-[selected=true]:text-accent-foreground">Search Emoji</CommandItem>
            <CommandItem class="text-sm text-foreground rounded-sm cursor-pointer select-none px-2 py-1.5 hover:bg-accent hover:text-accent-foreground data-[selected=true]:bg-accent data-[selected=true]:text-accent-foreground">Calculator</CommandItem>
          </CommandGroup>
        </CommandList>
      </Command>
    </div>
  {:else}
    <div class="flex-1"></div>
     <!-- {/* Spacer to push auth section to the right */} -->
  {/if}

  <div class="flex items-center"> 
    <!-- {/* Auth/User Profile Area (Right) */} -->
    <!-- {/* Placeholder for User Profile / Auth section - Styled */} -->
    <div class="w-10 h-10 bg-muted rounded-full flex items-center justify-center text-muted-foreground">
      <!-- {/* Could be an icon or initials */} -->
      <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-user"><path d="M19 21v-2a4 4 0 0 0-4-4H9a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/></svg>
    </div>
  </div>
</div>

<!-- No <style> block needed as all styles are Tailwind utility classes -->
<!-- The original style block for .topbar-container is removed as its properties are now directly on the div -->
