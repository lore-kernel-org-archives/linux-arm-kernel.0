From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 2 Oct 2017 22:40:16 +0200
Subject: [PATCH v3 07/12] ARM: dts: sun8i: a711: include axp81x dtsi
In-Reply-To: <20171002120854.5212-8-quentin.schulz@free-electrons.com>
References: <20171002120854.5212-1-quentin.schulz@free-electrons.com>
 <20171002120854.5212-8-quentin.schulz@free-electrons.com>
Message-ID: <20171002204016.ogaoesvz263leoj6@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 02, 2017 at 12:08:49PM +0000, Quentin Schulz wrote:
> This board has an AXP813 PMIC so let's include its dtsi.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
>  arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
> index 723641f56a74..4f4db07ca19f 100644
> --- a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
> +++ b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
> @@ -146,7 +146,7 @@
>  &r_rsb {
>  	status = "okay";
>  
> -	axp813: pmic at 3a3 {
> +	axp81x: pmic at 3a3 {

Aren't we going to have an axp813 DTSI? What's your plan here

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171002/f86d5263/attachment.sig>
