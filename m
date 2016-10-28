From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 28 Oct 2016 12:29:20 +0100
Subject: [GIT PULL] firmware: SCPI updates for v4.10
Message-ID: <20161028112920.GB12241@e107155-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM-SoC Team,

Please pull !

--
Regards,
Sudeep

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git tags/scpi-updates-4.10

for you to fetch changes up to a9e0192d8b35c6ab115a154ed1499ff39a0e5b06:

  firmware: arm_scpi: add support for legacy match table on Amlogic GXBB SoC (2016-10-19 15:17:28 +0100)

----------------------------------------------------------------
SCPI updates for v4.10

1. Adds support for Legacy SCPI(pre- SCPI v1.0) protocol

2. Adds support for SCPI used on Amlogic GXBB SoC using the legacy
   SCPI protocol

----------------------------------------------------------------
Neil Armstrong (5):
      dt-bindings: Add support for Amlogic GXBB SCPI Interface
      firmware: arm_scpi: increase MAX_DVFS_OPPS to 16 entries
      firmware: arm_scpi: add alternative legacy structures, functions and macros
      firmware: arm_scpi: allow firmware with get_capabilities not implemented
      firmware: arm_scpi: add support for legacy match table on Amlogic GXBB SoC

Sudeep Holla (1):
      firmware: arm_scpi: add command indirection to support legacy commands

 Documentation/devicetree/bindings/arm/arm,scpi.txt |   8 +-
 drivers/firmware/arm_scpi.c                        | 276 ++++++++++++++++++---
 2 files changed, 249 insertions(+), 35 deletions(-)
