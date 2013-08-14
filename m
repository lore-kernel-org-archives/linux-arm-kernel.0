From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 14 Aug 2013 13:17:46 +0800
Subject: [PATCH] phy: micrel: Add definitions for common Micrel PHY
 registers
In-Reply-To: <1376405940-17141-1-git-send-email-dinguyen@altera.com>
References: <1376405940-17141-1-git-send-email-dinguyen@altera.com>
Message-ID: <20130814051743.GG16915@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 13, 2013 at 09:58:59AM -0500, dinguyen at altera.com wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> Hi Shawn,
> 
> Can you apply this patch to your tree for 3.12?
> 

I need David's Ack to send the patch through IMX tree.

Shawn

> Thanks,
> 
> Dinh Nguyen (1):
>   phy: micrel: Add definitions for common Micrel PHY registers
> 
>  arch/arm/mach-at91/board-dt-sama5.c |   17 ++++++-----------
>  arch/arm/mach-imx/mach-imx6q.c      |   13 ++++++++-----
>  include/linux/micrel_phy.h          |    6 ++++++
>  3 files changed, 20 insertions(+), 16 deletions(-)
> 
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: David S. Miller <davem@davemloft.net>
> CC: Andrew Victor <linux@maxim.org.za>
> CC: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Cc: netdev at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> 
> -- 
> 1.7.9.5
> 
> 
