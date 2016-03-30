From: kaloz@openwrt.org (Imre Kaloz)
Date: Wed, 30 Mar 2016 11:05:37 +0200
Subject: [PATCH v2] ARM: mvebu: Correct unit address for linksys
In-Reply-To: <1459270660-30411-1-git-send-email-patrick@puiterwijk.org>
References: <1459270660-30411-1-git-send-email-patrick@puiterwijk.org>
Message-ID: <op.ye4rjnln2s3iss@ecaz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Right, a165c3b63b6f24fdc47c270db5f8b1a48b69c1b6 was merged sooner then  
this board setup file.

Acked-by: Imre Kaloz <kaloz@openwrt.org>

On Tue, 29 Mar 2016 18:57:40 +0200, Patrick Uiterwijk  
<patrick@puiterwijk.org> wrote:

> The USB2 port for Armada 38x is defined to be at 58000, not at
> 50000.
>
> Signed-off-by: Patrick Uiterwijk <patrick@puiterwijk.org>
> ---
>  arch/arm/boot/dts/armada-385-linksys.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/armada-385-linksys.dtsi  
> b/arch/arm/boot/dts/armada-385-linksys.dtsi
> index 3710755..85d2c37 100644
> --- a/arch/arm/boot/dts/armada-385-linksys.dtsi
> +++ b/arch/arm/boot/dts/armada-385-linksys.dtsi
> @@ -117,7 +117,7 @@
>  			};
> 			/* USB part of the eSATA/USB 2.0 port */
> -			usb at 50000 {
> +			usb at 58000 {
>  				status = "okay";
>  			};
