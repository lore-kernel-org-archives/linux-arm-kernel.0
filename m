From: moore@free.fr (Chris Moore)
Date: Sun, 14 May 2017 06:28:48 +0200
Subject: [PATCH v2 02/18] arm64: dts: amlogic: Sort Makefile
In-Reply-To: <20170513143337.14278-3-afaerber@suse.de>
References: <20170513143337.14278-1-afaerber@suse.de>
 <20170513143337.14278-3-afaerber@suse.de>
Message-ID: <2e9efe9b-6bfe-ab69-8811-c85e1a8ec9f9@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 13/05/2017 ? 16:33, Andreas F?rber a ?crit :
> Sort the .dtb files alphabetically to make clear where to add new ones.
>
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>   v1 -> v2:
>   * Rebased (new boards added)
>   * Extended commit message
>   
>   arch/arm64/boot/dts/amlogic/Makefile | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
> index b9ad2db7398b..14fa27ccd589 100644
> --- a/arch/arm64/boot/dts/amlogic/Makefile
> +++ b/arch/arm64/boot/dts/amlogic/Makefile
> @@ -7,15 +7,15 @@ dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-vega-s95-meta.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-vega-s95-telos.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-wetek-hub.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-wetek-play2.dtb
> +dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-hwacom-amazetv.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-khadas-vim.dtb
> +dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-nexbox-a95x.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-p212.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-p230.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-p231.dtb

s905d should be before s905x if you are imposing alphabetical order.

> -dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-hwacom-amazetv.dtb
> -dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-nexbox-a95x.dtb
> +dtb-$(CONFIG_ARCH_MESON) += meson-gxm-nexbox-a1.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-gxm-q200.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-gxm-q201.dtb
> -dtb-$(CONFIG_ARCH_MESON) += meson-gxm-nexbox-a1.dtb
>   
>   always		:= $(dtb-y)
>   subdir-y	:= $(dts-dirs)
