From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Mon, 25 Aug 2014 14:53:09 +0800
Subject: [PATCH 1/2] ARM: pxa: dts: fix mmc controller compatible string
In-Reply-To: <1408009573-24523-1-git-send-email-zonque@gmail.com>
References: <1408009573-24523-1-git-send-email-zonque@gmail.com>
Message-ID: <CAN1soZyeXsKFHsUU8d8-7SFBECa_ExrMSCvf5WE578LVaMVaLw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 14, 2014 at 5:46 PM, Daniel Mack <zonque@gmail.com> wrote:
> The vendor prefix was renamed from "mrvl" to "marvell". Follow this
> change in the dts file.
>
> Signed-off-by: Daniel Mack <zonque@gmail.com>
> ---
>  arch/arm/boot/dts/pxa2xx.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/pxa2xx.dtsi b/arch/arm/boot/dts/pxa2xx.dtsi
> index febd391..f188f8c 100644
> --- a/arch/arm/boot/dts/pxa2xx.dtsi
> +++ b/arch/arm/boot/dts/pxa2xx.dtsi
> @@ -128,7 +128,7 @@
>                 };
>
>                 mmc0: mmc at 41100000 {
> -                       compatible = "mrvl,pxa-mmc";
> +                       compatible = "marvell,pxa-mmc";
>                         reg = <0x41100000 0x1000>;
>                         interrupts = <23>;
>                         dmas = <&dma 21
> --
> 2.0.4
>

Applied these 2 patches.

Regards
Haojian
