<script>
	import '../app.css';
	import { setMode, ModeWatcher } from 'mode-watcher';
	setMode('dark');
</script>

<ModeWatcher />
<div class="flex flex-col items-center  min-h-screen py-2">
<slot />

</div>