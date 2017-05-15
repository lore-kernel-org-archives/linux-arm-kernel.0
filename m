From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Mon, 15 May 2017 22:16:34 +0200
Subject: [PATCH v2 06/18] arm64: dts: meson-gxl-s905x-khadas-vim: Fix Wifi
 node name
In-Reply-To: <20170513143337.14278-7-afaerber@suse.de>
References: <20170513143337.14278-1-afaerber@suse.de>
 <20170513143337.14278-7-afaerber@suse.de>
Message-ID: <CAFBinCDqm3h08KKSmS02aPGLToU5SXSJ6GdRKFkt4NC=87gR+g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 13, 2017 at 4:33 PM, Andreas F?rber <afaerber@suse.de> wrote:
> bcrmf -> brcmf -> wifi
>
> Fixes: e15d2774b8c0 ("ARM64: dts: meson-gxl: add support for the Khadas VIM board")
> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>


> ---
>  v2: New
>
>  arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
> index 3c8b0b51ef27..6a81f0168da5 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
> @@ -95,7 +95,7 @@
>  };
>
>  &sd_emmc_a {
> -       brcmf: bcrmf at 1 {
> +       brcmf: wifi at 1 {
>                 reg = <1>;
>                 compatible = "brcm,bcm4329-fmac";
>         };
> --
> 2.12.0
>
