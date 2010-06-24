From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 24 Jun 2010 11:57:01 +0300
Subject: [PATCH -next 0/2] mx25: add iomux defines
Message-ID: <cover.1277369614.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds some iomux defines needed for the UART4 and the PWM4 devices.

This version applies to current imx-for-2.6.36.

Baruch Siach (2):
  mx25: add iomux defines for UART4 on KPP pins
  mx25: add PWM4 to iomux

 arch/arm/plat-mxc/include/mach/iomux-mx25.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)
