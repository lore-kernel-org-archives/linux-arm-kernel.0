From: bcm@fixthebug.org (Christian Daudt)
Date: Tue, 1 Oct 2013 18:13:48 -0700
Subject: [PATCH v2] ARM: dts: bcm281xx: Add card detect GPIO
In-Reply-To: <1380566353-13815-1-git-send-email-markus.mayer@linaro.org>
References: <1380566353-13815-1-git-send-email-markus.mayer@linaro.org>
Message-ID: <CAEPRUYqO0tnXsxP+04cEsi9Bv3EZ0JpN+LwxWbNBQ=aOSwov0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 30, 2013 at 11:39 AM, Markus Mayer <markus.mayer@linaro.org> wrote:
> Register GPIO 14 as card detect interrupt for the SD card slot.
>
> Signed-off-by: Markus Mayer <markus.mayer@linaro.org>
> ---
>
> Changes since v1:
> - Corrected commit message to mention "card detect"
>
>  arch/arm/boot/dts/bcm11351.dtsi |    1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/boot/dts/bcm11351.dtsi b/arch/arm/boot/dts/bcm11351.dtsi
> index 05a5aab..d384ed5 100644
> --- a/arch/arm/boot/dts/bcm11351.dtsi
> +++ b/arch/arm/boot/dts/bcm11351.dtsi
> @@ -93,6 +93,7 @@
>                 compatible = "brcm,kona-sdhci";
>                 reg = <0x3f1b0000 0x10000>;
>                 interrupts = <0x0 73 0x4>;
> +               cd-gpios = <&gpio 14 0>;
>                 status = "disabled";
>         };
>
> --
> 1.7.9.5
>
>

Reviewed-by: Christian Daudt <bcm@fixthebug.org>
Applied to armsoc/for-3.13/dt

 thanks,
   csd
