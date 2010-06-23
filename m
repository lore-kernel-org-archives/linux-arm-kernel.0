From: baruch@tkos.co.il (Baruch Siach)
Date: Wed, 23 Jun 2010 13:31:25 +0300
Subject: [PATCH 0/2] mx25: add iomux defines
Message-ID: <cover.1277288487.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds some iomux defines needed for the UART4 and the PWM4 devices.

Baruch Siach (2):
  mx25: add iomux defines for UART4 on KPP pins
  mx25: add PWM4 to iomux

 arch/arm/plat-mxc/include/mach/iomux-mx25.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)
