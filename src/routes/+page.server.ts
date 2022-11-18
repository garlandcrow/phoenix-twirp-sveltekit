import { error, invalid, redirect } from '@sveltejs/kit'
import type { PageServerLoad, Actions } from './$types'

export const load: PageServerLoad = async function (event) {
  return {}
}

export const actions: Actions = {
  default: async (event) => {
    return {
  },
}