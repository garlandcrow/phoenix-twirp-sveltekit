import { TwirpFetchTransport } from '@protobuf-ts/twirp-transport';
import { HaberdasherClient } from '../service.client';
import type { PageLoad } from './$types';

export const load: PageLoad = async function () {
	const transport = new TwirpFetchTransport({ baseUrl: 'http://localhost:4000/rpc/hat/twirp' });
	const client = new HaberdasherClient(transport);
	const call = await client.makeHat({ inches: 23 });

	return { hat: call.response };
};
