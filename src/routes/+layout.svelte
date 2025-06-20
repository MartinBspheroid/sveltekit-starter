<script lang="ts">
	import '../app.css';
	import { setMode, ModeWatcher } from 'mode-watcher';
	import { onNavigate } from '$app/navigation';
	interface Props {
		children?: import('svelte').Snippet;
	}

	let { children }: Props = $props();
	setMode('light');

	onNavigate((navigation) => {
		if (!document.startViewTransition) return;

		return new Promise((resolve) => {
			document.startViewTransition(async () => {
				resolve();
				await navigation.complete;
			});
		});
	});
</script>

<ModeWatcher />
<div class="flex min-h-screen flex-col items-center py-2">
	{@render children?.()}
</div>
 