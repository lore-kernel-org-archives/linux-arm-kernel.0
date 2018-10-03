From: vigneshr@ti.com (Vignesh R)
Date: Wed, 3 Oct 2018 22:36:56 +0530
Subject: [PATCH 0/2] pwm-tiecap: Add support for AM654 SoCs
Message-ID: <20181003170658.3835-1-vigneshr@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Couple of patches to enable pwm-tiecap driver to be used with TI's new
AM654 platforms.

Vignesh R (2):
  dt-bindings: pwm: tiecap: Add TI AM654 SoC specific compatible
  pwm: Kconfig: Enable TI ECAP driver for ARCH_K3

 Documentation/devicetree/bindings/pwm/pwm-tiecap.txt | 1 +
 drivers/pwm/Kconfig                                  | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
2.19.0
