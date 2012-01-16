From: paul.liu@linaro.org (Ying-Chun Liu (PaulLiu))
Date: Tue, 17 Jan 2012 01:10:52 +0800
Subject: [PATCH] mx53_loco: add DA9053 PMIC support
Message-ID: <1326733853-13956-1-git-send-email-paul.liu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>

Hi,

This patch adds da9053 init for Freescale QuickStart Loco board.
DA9053 is a MFD device. On QuickStart Loco board we are using the regulators
provided by it.

Please help us to review this patch.

Many Thanks.

Ying-Chun Liu (PaulLiu) (1):
  mx53_loco: add DA9053 PMIC support

 arch/arm/mach-mx5/board-mx53_loco.c   |  128 +++++++++++++++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/irqs.h |   10 +++-
 2 files changed, 137 insertions(+), 1 deletions(-)

-- 
1.7.8.3
