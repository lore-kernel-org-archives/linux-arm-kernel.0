From: eric@anholt.net (Eric Anholt)
Date: Tue, 27 Nov 2018 13:13:00 -0800
Subject: [GIT PULL 3/4] bcm2835-drivers-next-2018-11-27
In-Reply-To: <20181127211301.30296-1-eric@anholt.net>
References: <20181127211301.30296-1-eric@anholt.net>
Message-ID: <20181127211301.30296-3-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Florian,

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://github.com/anholt/linux tags/bcm2835-drivers-next-2018-11-27

for you to fetch changes up to 502b431cda801645fd73857f7b47a4666de3cb62:

  firmware: raspberrypi: Switch to SPDX identifier (2018-11-21 14:33:11 +0100)

----------------------------------------------------------------
This pull request adds SPDX to BCM2835 drivers, and fixes some bugs in
the firmware driver (silently hanging if the VPU doesn't respond to a
mailbox transaction, and undersized buffers in the firmware property
transactions for tags that aren't used yet in the upstream).

----------------------------------------------------------------
James Hughes (1):
      firmware: raspberrypi: Fix firmware calls with large buffers

Stefan Wahren (3):
      firmware: raspberrypi: Define timeout for transactions
      soc: bcm: Switch raspberrypi-power to SPDX identifier
      firmware: raspberrypi: Switch to SPDX identifier

 drivers/firmware/raspberrypi.c                | 48 ++++++++++++++-------------
 drivers/soc/bcm/raspberrypi-power.c           |  5 +--
 include/dt-bindings/power/raspberrypi-power.h |  5 +--
 include/soc/bcm2835/raspberrypi-firmware.h    |  5 +--
 4 files changed, 28 insertions(+), 35 deletions(-)
