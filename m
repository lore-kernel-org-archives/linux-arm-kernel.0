From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 13 Oct 2015 22:11:19 +0800
Subject: [PATCH 13/37] ARM: dts: exynos5250-arndale: Fix regulator enable
 GPIO polarity
In-Reply-To: <1444684386-17094-14-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1444684386-17094-1-git-send-email-laurent.pinchart@ideasonboard.com>
 <1444684386-17094-14-git-send-email-laurent.pinchart@ideasonboard.com>
Message-ID: <20151013141119.GC584@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 13, 2015 at 12:12:42AM +0300, Laurent Pinchart wrote:
> The enable GPIO is active high, but is flagged as active low in the gpio
> property. As the gpio property flags are currently unused by the driver
> this doesn't cause any issue for now, but will break later if the driver
> starts making use of the flags. Fix it.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
>  arch/arm/boot/dts/exynos5250-arndale.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>

This one should be sent to Samsung folks instead.

Shawn
