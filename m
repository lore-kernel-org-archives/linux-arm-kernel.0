From: pavel@denx.de (Pavel Machek)
Date: Thu, 18 Jul 2013 13:17:12 +0200
Subject: [PATCH] phy: micrel: Add definitions for common Micrel PHY
 registers
In-Reply-To: <1373929730-28130-1-git-send-email-dinguyen@altera.com>
References: <1373929730-28130-1-git-send-email-dinguyen@altera.com>
Message-ID: <20130718111712.GA1021@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 2013-07-15 18:08:50, dinguyen at altera.com wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> Add defines for common Micrel PHY setups so that other platforms
> can use them. Update imx61 and sama5 hardware to use the micrel_phy.h
> PHY defines.

Looks good to me.

> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> CC: Andrew Victor <linux@maxim.org.za>
> CC: Nicolas Ferre <nicolas.ferre@atmel.com>
> CC: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>

Reviewed-by: Pavel Machek <pavel@denx.de>
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
