<script lang="ts">
	import type { PageData } from './$types';

	export let data: PageData;
</script>

<h1>Haberdasher Service</h1>
{#if data.error}
	<h1>Error</h1>
	<p>{data.error}</p>
{:else if data.hat}
	{@const { color, name, inches } = data.hat}
	<h2>Delivered Hat</h2>
	<p>Color: {color}</p>
	<p>Name: {name}</p>
	<p>Inches: {inches}</p>
{/if}
