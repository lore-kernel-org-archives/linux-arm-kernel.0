From: robherring2@gmail.com (Rob Herring)
Date: Wed,  1 Jun 2011 11:37:47 -0500
Subject: [PATCH 0/3] DT bindings Cortex A9 peripherals
Message-ID: <1306946270-18379-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

This series adds DT based initialization and bindings for the pmu, gic and l2x0
found on Cortex-A9's.

Rob

Rob Herring (3):
  ARM: pmu: add OF probing support
  ARM: gic: add OF based initialization
  ARM: l2x0: Add OF based initialization

 arch/arm/common/gic.c                      |   35 +++++++++++++++++++++++++++
 arch/arm/include/asm/hardware/cache-l2x0.h |    1 +
 arch/arm/include/asm/hardware/gic.h        |    1 +
 arch/arm/kernel/pmu.c                      |   23 ++++++++++++++----
 arch/arm/mm/cache-l2x0.c                   |   36 ++++++++++++++++++++++++++++
 5 files changed, 91 insertions(+), 5 deletions(-)

-- 
1.7.4.1
