From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 17 Mar 2013 20:15:41 +0000
Subject: [GIT PULL 2/3] ARM: mvebu: drivers for v3.10
In-Reply-To: <1363551341.dDc8Eea0.32562@triton>
Message-ID: <1363551341.2c03A212.32562@triton>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit f6161aa153581da4a3867a2d1a7caf4be19b6ec9:

  Linux 3.9-rc2

are available in the git repository at:

  git://git.infradead.org/users/jcooper/linux.git tags/drivers_for_v3.10

for you to fetch changes up to edba98129498c4108e5b8a48335632b17048a62b:

  bus: introduce an Marvell EBU MBus driver

----------------------------------------------------------------
mvebu drivers for v3.10
    
     - mvebu: mbus driver for kirkwood, dove, orion5x, mv78xx, and armada 370/xp
----------------------------------------------------------------
Thomas Petazzoni (1):
      bus: introduce an Marvell EBU MBus driver

 .../devicetree/bindings/arm/mvebu-mbus.txt      |  39 +
 drivers/bus/Kconfig                             |   7 +
 drivers/bus/Makefile                            |   1 +
 drivers/bus/mvebu-mbus.c                        | 906 +++++++++++++++++++
 include/linux/mbus.h                            |  25 +-
 5 files changed, 977 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/arm/mvebu-mbus.txt
 create mode 100644 drivers/bus/mvebu-mbus.c
