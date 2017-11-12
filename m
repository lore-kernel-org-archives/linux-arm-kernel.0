From: pali.rohar@gmail.com (Pali =?utf-8?B?Um9ow6Fy?=)
Date: Sun, 12 Nov 2017 13:07:15 +0100
Subject: [PATCH] omap3-n900: enable autofocus
In-Reply-To: <20171112112528.GA21009@amd>
References: <20171112112528.GA21009@amd>
Message-ID: <20171112120715.lyiwwvqileospbqv@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 12 November 2017 12:25:29 Pavel Machek wrote:
> 
> Connect auto-focus coil to the camera sensor, so that it can be used
> by camera applications.
> 
> Signed-off-by: Pavel Machek <pavel@ucw.cz>

Acked-by: Pali Roh?r <pali.rohar@gmail.com>

> diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
> index 669c51c..59cc743 100644
> --- a/arch/arm/boot/dts/omap3-n900.dts
> +++ b/arch/arm/boot/dts/omap3-n900.dts
> @@ -778,6 +778,8 @@
>  
>  		reset-gpio = <&gpio4 6 GPIO_ACTIVE_HIGH>; /* 102 */
>  
> +		lens-focus = <&ad5820>;
> +
>  		port {
>  			csi_cam1: endpoint {
>  				bus-type = <3>; /* CCP2 */
> 

-- 
Pali Roh?r
pali.rohar at gmail.com
