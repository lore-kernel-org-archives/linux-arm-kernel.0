From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 11 May 2018 15:02:40 -0700
Subject: [PATCH 0/2] soc: bcm: brcmstb: Updates to support newer controllers
Message-ID: <20180511220242.837-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This patch series adds support for newer reveisions of the memory controller
which is necessary to make sure we do use the right programming sequence to
enter S2 and S3 suspend/resume modes.

Doug Berger (1):
  soc: bcm: brcmstb: pm: Add support for newer rev B3.0 controllers

Florian Fainelli (1):
  soc: bcm: brcmstb: Add missing DDR MEMC compatible strings

 .../devicetree/bindings/arm/bcm/brcm,brcmstb.txt         |  4 ++++
 drivers/soc/bcm/brcmstb/pm/pm-arm.c                      | 16 ++++++++++++++++
 2 files changed, 20 insertions(+)

-- 
2.14.1
