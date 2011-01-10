From: eballetbo@gmail.com (Enric Balletbo i Serra)
Date: Mon, 10 Jan 2011 14:26:11 +0100
Subject: [PATCH 0/3] IGEP board changes for .38 merge window
Message-ID: <1294665974-10590-1-git-send-email-eballetbo@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

Here's a new patches for IGEP boards. These patches are rebased on top of your 
for-next tree. Please consider adding for .38 merge window. Thanks.

Cheers,

Enric Balletbo i Serra (3):
  omap3: igep3: Add USB EHCI support for IGEP module.
  omap3: igep3: Fix IGEP module second MMC channel power supply.
  omap3: igep2: Add keypad support.

 arch/arm/mach-omap2/board-igep0020.c |   33 ++++++++++++++
 arch/arm/mach-omap2/board-igep0030.c |   80 +++++++++++++++++++++++++++++-----
 2 files changed, 102 insertions(+), 11 deletions(-)
