From: tharvey@gateworks.com (Tim Harvey)
Date: Thu, 12 Jan 2017 11:37:32 -0800
Subject: [PATCH v3 10/24] ARM: dts: imx6-sabreauto: add pinctrl for gpt
 input capture
In-Reply-To: <1483755102-24785-11-git-send-email-steve_longerbeam@mentor.com>
References: <1483755102-24785-1-git-send-email-steve_longerbeam@mentor.com>
 <1483755102-24785-11-git-send-email-steve_longerbeam@mentor.com>
Message-ID: <CAJ+vNU1ci=fbeemJcBGCAk40PETdcov7Fm112F5FePL9SR4cFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 6, 2017 at 6:11 PM, Steve Longerbeam <slongerbeam@gmail.com> wrote:
> Add pinctrl groups for both GPT input capture channels.
>
> Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
> ---
>  arch/arm/boot/dts/imx6qdl-sabreauto.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
> index 967c3b8..495709f 100644
> --- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
> @@ -457,6 +457,18 @@
>                         >;
>                 };
>
> +               pinctrl_gpt_input_capture0: gptinputcapture0grp {
> +                       fsl,pins = <
> +                               MX6QDL_PAD_SD1_DAT0__GPT_CAPTURE1       0x1b0b0
> +                       >;
> +               };
> +
> +               pinctrl_gpt_input_capture1: gptinputcapture1grp {
> +                       fsl,pins = <
> +                               MX6QDL_PAD_SD1_DAT1__GPT_CAPTURE2       0x1b0b0
> +                       >;
> +               };
> +
>                 pinctrl_spdif: spdifgrp {
>                         fsl,pins = <
>                                 MX6QDL_PAD_KEY_COL3__SPDIF_IN 0x1b0b0
> --

Steve,

These are not used anywhere.

Tim
