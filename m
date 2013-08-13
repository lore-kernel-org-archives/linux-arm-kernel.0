From: dinguyen@altera.com (dinguyen at altera.com)
Date: Tue, 13 Aug 2013 09:58:59 -0500
Subject: [PATCH] phy: micrel: Add definitions for common Micrel PHY registers
Message-ID: <1376405940-17141-1-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

Hi Shawn,

Can you apply this patch to your tree for 3.12?

Thanks,

Dinh Nguyen (1):
  phy: micrel: Add definitions for common Micrel PHY registers

 arch/arm/mach-at91/board-dt-sama5.c |   17 ++++++-----------
 arch/arm/mach-imx/mach-imx6q.c      |   13 ++++++++-----
 include/linux/micrel_phy.h          |    6 ++++++
 3 files changed, 20 insertions(+), 16 deletions(-)

Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: David S. Miller <davem@davemloft.net>
CC: Andrew Victor <linux@maxim.org.za>
CC: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: netdev at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org

-- 
1.7.9.5
