From: robherring2@gmail.com (Rob Herring)
Date: Sat,  1 Feb 2014 16:35:41 -0600
Subject: [PATCH 0/3] kconfig selection fixes
Message-ID: <1391294144-27787-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <robh@kernel.org>

Olof,

Here are a few kconfig select fixes. The first one can be squashed into
my previous patch for HiSilicon removing SMP select if you want to. 

I'm still looking into the cpufreq select issue with highbank. I'll
follow-up with Viresh on that.

Rob

Rob Herring (3):
  ARM: hisi: fix kconfig warning on HAVE_ARM_TWD
  ARM: moxart: move DMA_OF selection to driver
  ARM: fix HAVE_ARM_TWD selection for OMAP and shmobile

 arch/arm/mach-hisi/Kconfig     | 2 +-
 arch/arm/mach-moxart/Kconfig   | 1 -
 arch/arm/mach-omap2/Kconfig    | 2 +-
 arch/arm/mach-shmobile/Kconfig | 2 +-
 drivers/dma/Kconfig            | 1 +
 5 files changed, 4 insertions(+), 4 deletions(-)

-- 
1.8.3.2
