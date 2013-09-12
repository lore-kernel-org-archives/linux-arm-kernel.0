From: nm@ti.com (Nishanth Menon)
Date: Thu, 12 Sep 2013 11:19:11 -0500
Subject: [PATCH 3/4] ARM: am335x-bone-common: switch mmc1 to 4-bit mode
In-Reply-To: <1379000532-27376-4-git-send-email-koen@dominion.thruhere.net>
References: <1379000532-27376-1-git-send-email-koen@dominion.thruhere.net>
 <1379000532-27376-4-git-send-email-koen@dominion.thruhere.net>
Message-ID: <5231E97F.1060005@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

nitpick minor comment:
$subject: ARM: dts: am335x-bone-common: switch mmc1 to 4-bit mode

On 09/12/2013 10:42 AM, Koen Kooi wrote:
> The micro-SD slot hooks up all four data pins so lets' use them.
> 
> Signed-off-by: Koen Kooi <koen@dominion.thruhere.net>
> ---
>  arch/arm/boot/dts/am335x-bone-common.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
> index cfec441..80407ff 100644
> --- a/arch/arm/boot/dts/am335x-bone-common.dtsi
> +++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
> @@ -290,6 +290,7 @@
>  
>  &mmc1 {
>  	status = "okay";
> +	bus-width = <0x4>;
>  	vmmc-supply = <&ldo3_reg>;
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&mmc1_pins>;
> 


-- 
Regards,
Nishanth Menon
