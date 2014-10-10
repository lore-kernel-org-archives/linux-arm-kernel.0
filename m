From: balbi@ti.com (Felipe Balbi)
Date: Fri, 10 Oct 2014 13:08:49 -0500
Subject: [PATCH 11/12] ARM: dts: am33xx: update rtc node compatible
 property
In-Reply-To: <1412881594-25678-12-git-send-email-johan@kernel.org>
References: <1412881594-25678-1-git-send-email-johan@kernel.org>
 <1412881594-25678-12-git-send-email-johan@kernel.org>
Message-ID: <20141010180849.GY31348@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 09, 2014 at 09:06:33PM +0200, Johan Hovold wrote:
> Enable am33xx specific RTC features (e.g. PMIC control) by adding
> "ti,am3352-rtc" to the compatible property of the rtc node.
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: Felipe Balbi <balbi@ti.com>

> ---
>  arch/arm/boot/dts/am33xx.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index 3a0a161342ba..098e53602d5c 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -411,7 +411,7 @@
>  		};
>  
>  		rtc: rtc at 44e3e000 {
> -			compatible = "ti,da830-rtc";
> +			compatible = "ti,am3352-rtc", "ti,da830-rtc";
>  			reg = <0x44e3e000 0x1000>;
>  			interrupts = <75
>  				      76>;
> -- 
> 2.0.4
> 

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141010/c1ae66ae/attachment.sig>
