From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 15 May 2013 11:15:01 +0200
Subject: [PATCH v2 4/4] ARM: shmobile: marzen-reference: Set SMSC lan to
 use irq-push-pull
In-Reply-To: <1368586650-26263-5-git-send-email-horms+renesas@verge.net.au>
References: <1368586650-26263-1-git-send-email-horms+renesas@verge.net.au>
 <1368586650-26263-5-git-send-email-horms+renesas@verge.net.au>
Message-ID: <10371644.BMkVSLAUGy@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

Thanks for the patch.

On Wednesday 15 May 2013 11:57:30 Simon Horman wrote:
> This change makes the DTS consistent with the platform data
> that exists in board-marzen.c.
> 
> Empirically it does not appear to be necessary.
> 
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  arch/arm/boot/dts/r8a7779-marzen-reference.dts | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/r8a7779-marzen-reference.dts
> b/arch/arm/boot/dts/r8a7779-marzen-reference.dts index 10cfc7f..fe32e1a
> 100644
> --- a/arch/arm/boot/dts/r8a7779-marzen-reference.dts
> +++ b/arch/arm/boot/dts/r8a7779-marzen-reference.dts
> @@ -40,6 +40,7 @@
>  		phy-mode = "mii";
>  		interrupt-parent = <&irqpin0>;
>  		interrupts = <1 0x4>;
> +		smsc,irq-push-pull;
>  		reg-io-width = <4>;
>  		vddvario-supply = <&fixedregulator3v3>;
>  		vdd33a-supply = <&fixedregulator3v3>;
-- 
Regards,

Laurent Pinchart
