<script lang="ts">
	import type { PageData } from './$types';
	import { TwirpFetchTransport } from '@protobuf-ts/twirp-transport';
	import { onMount } from 'svelte';
	import type { Hat } from '../service';
	import { HaberdasherClient } from '../service.client';

	export let data: PageData;
	$: console.debug(`src/routes/+page.svelte(9): data :>> `, data);
	$: hat = data.hat;
	// onMount(async () => {
	// 	const transport = new TwirpFetchTransport({
	// 		baseUrl: 'http://localhost:4000/rpc/hat/twirp',
	// 		sendJson: true
	// 	});
	// 	const client = new HaberdasherClient(transport);
	// 	const call = await client.makeHat({ inches: 23 });

	// 	hat = call.response;
	// });
</script>

<h1>Hat</h1>
<p>{hat?.name ?? 'fuck'}</p>
