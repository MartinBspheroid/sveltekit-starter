<script lang="ts">
	import '../app.css';
	import { setMode, ModeWatcher } from 'mode-watcher';
	interface Props {
		children?: import('svelte').Snippet;
	}

	let { children }: Props = $props();
	setMode('dark');
</script>

<ModeWatcher />
<div class="flex flex-col items-center  min-h-screen py-2">
{@render children?.()}

</div>