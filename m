From: vigneshr@ti.com (Vignesh R)
Date: Tue, 16 Oct 2018 11:34:00 +0530
Subject: [PATCH v2 0/2] pwm-tiecap: Add support for AM654 SoCs
Message-ID: <20181016060402.18756-1-vigneshr@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Couple of patches to enable pwm-tiecap driver to be used with TI's new
AM654 platforms.

Vignesh R (2):
  dt-bindings: pwm: tiecap: Add TI AM654 SoC specific compatible
  pwm: Kconfig: Enable TI ECAP driver for ARCH_K3

 Documentation/devicetree/bindings/pwm/pwm-tiecap.txt | 1 +
 drivers/pwm/Kconfig                                  | 5 ++---
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.19.1
