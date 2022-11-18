import { TwirpFetchTransport } from '@protobuf-ts/twirp-transport';
import { HaberdasherClient } from '$lib/proto/service.client';
import type { PageLoad } from './$types';
import { RpcError } from '@protobuf-ts/runtime-rpc';
import { getErrorMessage } from '$lib/error';

export const load: PageLoad = async function () {
	try {
		const transport = new TwirpFetchTransport({ baseUrl: 'http://localhost:4000/rpc/hat/twirp' });
		const client = new HaberdasherClient(transport);
		const call = await client.makeHat({ inches: -23 });

		return { hat: call.response };
	} catch (err) {
		console.debug(`src/routes/+page.ts(14): err :>> `, err);

		let error = '';
		if (err instanceof RpcError) {
			error += err.serviceName ? `${err.serviceName}.` : '';
			error += err.methodName ? `${err.methodName}()` : '';
			error += err.code === 'UNKNOWN' ? ' : ' : ` [${err.code}] : `;
		}
		error += getErrorMessage(err);

		return { error };
	}
};
