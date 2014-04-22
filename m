From: robherring2@gmail.com (Rob Herring)
Date: Tue, 22 Apr 2014 14:41:15 -0500
Subject: [PATCH 0/3] ARM mach Kconfig clean-ups
Message-ID: <1398195678-28787-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <robh@kernel.org>

This is a follow-up to the multi-platform kconfig clean-ups I did for 
3.15. This is fixing new things which got introduced in 3.15. For 
example, the BCM2835 changes appear to have been lost with its move to 
mach-bcm.

Rob

Rob Herring (3):
  ARM: mvebu: clean-up unneeded kconfig selects
  ARM: bcm: clean-up unneeded kconfig selects
  ARM: qcom: clean-up unneeded kconfig selects

 arch/arm/mach-bcm/Kconfig   | 8 --------
 arch/arm/mach-mvebu/Kconfig | 6 ------
 arch/arm/mach-qcom/Kconfig  | 2 --
 3 files changed, 16 deletions(-)

-- 
1.9.1
