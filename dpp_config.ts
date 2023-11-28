import {
	BaseConfig,
	ContextBuilder,
	Dpp,
	Plugin,
} from "https://deno.land/x/dpp_vim@v0.0.7/types.ts";
import { Denops, fn } from "https://deno.land/x/dpp_vim@v0.0.7/deps.ts";

type Toml = {
	hooks_file?: string;
	ftplugins?: Record<string, string>;
	plugins?: Plugin[];
}

type LazyMakeStateResult = {
	plugins: Plugin[];
	stateLines: string[];
};

export class Config extends BaseConfig {
	override async config(args: {
		denops: Denops;
		contextBuilder: ContextBuilder;
		basePath: string;
		dpp: Dpp;
	}): Promise<{
		plugins: Plugin[],
		stateLines: string[],
	}> {
		args.contextBuilder.setGlobal({
			protocols: ["git"],
		});

		const [context, options] = await args.contextBuilder.get(args.denops);

		const toml = await args.dpp.extAction(
			args.denops,
			context,
			options,
			"toml",
			"load",
			{
				path: '~/dotfiles/toml/dpp.toml',
				options: {
					lazy: false,
				},
			},
		) as Toml[];

		const recordPlugins: Record<string, Plugin> = {};

		for (const plugin of toml.plugins ?? []) {
			recordPlugins[plugin.name] = plugin;
		}

		const res = await args.dpp.extAction(
			args.denops,
			context,
			options,
			"lazy",
			"makeState",
			{
				plugins: Object.values(recordPlugins),
			},
		) as LazyMakeStateResult;

		console.log("hoge")

		return {
			plugins: res?.plugins ?? [],
			stateLines: res?.stateLines ?? [],
		};
	}
}
