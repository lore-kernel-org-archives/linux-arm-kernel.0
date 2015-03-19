From: pbrobinson@gmail.com (Peter Robinson)
Date: Thu, 19 Mar 2015 18:43:28 +0000
Subject: [PATCH] ARM: dts: imx27: fix typo in makefile
In-Reply-To: <1426789318-30637-1-git-send-email-vincent.stehle@freescale.com>
References: <1426789318-30637-1-git-send-email-vincent.stehle@freescale.com>
Message-ID: <CALeDE9OV_gLz9BBPL4Lv5+H0900XyFB_+CwRTAZ5HmYo4952YQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 19, 2015 at 6:21 PM, Vincent Stehl?
<vincent.stehle@freescale.com> wrote:
> Commit cb612390e546 ("ARM: dts: Only build dtb if associated Arch and/or SoC is
> enabled") conditioned the generation of i.MX27 systems dts with
> CONFIG_SOC_IMX31; fix this typo.
>
> Signed-off-by: Vincent Stehl? <vincent.stehle@freescale.com>

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>

> Cc: Shawn Guo <shawn.guo@freescale.com>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Rob Herring <robh+dt@kernel.org>
> ---
>  arch/arm/boot/dts/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index a1c776b..992ea0b 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -215,7 +215,7 @@ dtb-$(CONFIG_SOC_IMX25) += \
>         imx25-eukrea-mbimxsd25-baseboard-dvi-vga.dtb \
>         imx25-karo-tx25.dtb \
>         imx25-pdk.dtb
> -dtb-$(CONFIG_SOC_IMX31) += \
> +dtb-$(CONFIG_SOC_IMX27) += \
>         imx27-apf27.dtb \
>         imx27-apf27dev.dtb \
>         imx27-eukrea-mbimxsd27-baseboard.dtb \
> --
> 2.1.4
>
