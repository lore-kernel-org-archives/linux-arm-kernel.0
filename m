From: alanbutty12@gmail.com (Alan M Butler)
Date: Fri, 17 Aug 2012 10:56:13 +0100
Subject: [PATCH] ARM: Kirkwood: Iomega IX2-200 Device Tree Support Patch v2
Message-ID: <cover.1345196553.git.alanbutty12@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixed some typo's and renamed the leds.
The patch should follow in the next email.
sorry bout subject of the email still getting used to to git and sendmail

Alan M Butler (1):
  ARM: Kirkwood: Iomega IX2-200 Device Tree Support Patch v2    
    Signed-off-by: Alan M Butler <alanbutty12@gmail.com>

 arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts |  105 +++++++++++++++++++++++++
 arch/arm/mach-kirkwood/Kconfig                |    7 ++
 arch/arm/mach-kirkwood/Makefile               |    1 +
 arch/arm/mach-kirkwood/Makefile.boot          |    1 +
 arch/arm/mach-kirkwood/board-dt.c             |    4 +
 arch/arm/mach-kirkwood/board-iomega_ix2_200.c |   79 +++++++++++++++++++
 arch/arm/mach-kirkwood/common.h               |    6 ++
 7 files changed, 203 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts
 create mode 100644 arch/arm/mach-kirkwood/board-iomega_ix2_200.c

-- 
1.7.5.4
