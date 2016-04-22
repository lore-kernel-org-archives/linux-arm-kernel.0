From: ivo.g.dimitrov.75@gmail.com (Ivaylo Dimitrov)
Date: Fri, 22 Apr 2016 07:34:43 +0300
Subject: [PATCH] ARM: dts: omap3: Fix ISP syscon register offset
In-Reply-To: <1460787628-17316-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
References: <1460787628-17316-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Message-ID: <5719A9E3.1000902@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 16.04.2016 09:20, Ivaylo Dimitrov wrote:
> According to the TRM, SCM CONTROL_CSIRXFE register is on offset 0x6c
>
> Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
> ---
>   arch/arm/boot/dts/omap34xx.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/omap34xx.dtsi b/arch/arm/boot/dts/omap34xx.dtsi
> index 5cdba1f..e446562 100644
> --- a/arch/arm/boot/dts/omap34xx.dtsi
> +++ b/arch/arm/boot/dts/omap34xx.dtsi
> @@ -46,7 +46,7 @@
>   			       0x480bd800 0x017c>;
>   			interrupts = <24>;
>   			iommus = <&mmu_isp>;
> -			syscon = <&scm_conf 0xdc>;
> +			syscon = <&scm_conf 0x6c>;
>   			ti,phy-type = <OMAP3ISP_PHY_TYPE_COMPLEX_IO>;
>   			#clock-cells = <1>;
>   			ports {
>

Anyone going to review that?
