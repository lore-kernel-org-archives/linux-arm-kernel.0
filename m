From: masami.hiramatsu@linaro.org (Masami Hiramatsu)
Date: Tue, 20 Feb 2018 19:21:43 +0900
Subject: [PATCH] ASoC: uniphier: evea: fix typo 'eva' -> 'evea'
In-Reply-To: <20180220095310.13464-1-suzuki.katsuhiro@socionext.com>
References: <20180220095310.13464-1-suzuki.katsuhiro@socionext.com>
Message-ID: <CAA93ih00RV2rhfMyLupxe+-3xvkLyA-TgpzybPKm4E0FqTJKOg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-02-20 18:53 GMT+09:00 Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>:

Looks good to me:)

Reviewed-by: Masami Hiramatsu <masami.hiramatsu@linaro.org>

Thanks,

> Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
> ---
>  sound/soc/uniphier/evea.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/sound/soc/uniphier/evea.c b/sound/soc/uniphier/evea.c
> index cad7e60de21d..ac2d30b55fb6 100644
> --- a/sound/soc/uniphier/evea.c
> +++ b/sound/soc/uniphier/evea.c
> @@ -292,7 +292,7 @@ static int evea_set_switch_hp(struct snd_kcontrol *kcontrol,
>         return evea_update_switch_hp(evea);
>  }
>
> -static const struct snd_kcontrol_new eva_controls[] = {
> +static const struct snd_kcontrol_new evea_controls[] = {
>         SOC_SINGLE_BOOL_EXT("Line Capture Switch", 0,
>                             evea_get_switch_lin, evea_set_switch_lin),
>         SOC_SINGLE_BOOL_EXT("Line Playback Switch", 0,
> @@ -384,8 +384,8 @@ static struct snd_soc_component_driver soc_codec_evea = {
>         .num_dapm_widgets       = ARRAY_SIZE(evea_widgets),
>         .dapm_routes            = evea_routes,
>         .num_dapm_routes        = ARRAY_SIZE(evea_routes),
> -       .controls               = eva_controls,
> -       .num_controls           = ARRAY_SIZE(eva_controls),
> +       .controls               = evea_controls,
> +       .num_controls           = ARRAY_SIZE(evea_controls),
>         .idle_bias_on           = 1,
>         .use_pmdown_time        = 1,
>         .endianness             = 1,
> --
> 2.16.1
>



-- 
Masami Hiramatsu
