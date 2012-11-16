From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 16 Nov 2012 10:29:08 +0100
Subject: [GIT PULL] Marvell driver changes for v3.8 merge window
Message-ID: <1353058151-27922-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Jason,

This pull request adds the mvneta network driver, which has received
the Ack from David Miller, who also agreed that we carry it through
the arm-soc tree. See:
http://www.spinics.net/lists/netdev/msg216770.html.

Thanks!

The following changes since commit 77b67063bb6bce6d475e910d3b886a606d0d91f7:

  Linux 3.7-rc5 (2012-11-11 13:44:33 +0100)

are available in the git repository at:

  git at github.com:MISL-EBU-System-SW/mainline-public.git tags/marvell-neta-for-3.8

for you to fetch changes up to 370b8ed905aa0c03125635169b6bcb69c3a91cdf:

  net: mvneta: update MAINTAINERS file for the mvneta maintainers (2012-11-16 10:21:38 +0100)

----------------------------------------------------------------
Marvell mvneta network driver, for 3.8

----------------------------------------------------------------
Thomas Petazzoni (3):
      net: mvmdio: new Marvell MDIO driver
      net: mvneta: driver for Marvell Armada 370/XP network unit
      net: mvneta: update MAINTAINERS file for the mvneta maintainers

 .../bindings/net/marvell-armada-370-neta.txt       |   23 +
 .../devicetree/bindings/net/marvell-orion-mdio.txt |   35 +
 MAINTAINERS                                        |    6 +
 drivers/net/ethernet/marvell/Kconfig               |   24 +
 drivers/net/ethernet/marvell/Makefile              |    2 +
 drivers/net/ethernet/marvell/mvmdio.c              |  230 ++
 drivers/net/ethernet/marvell/mvneta.c              | 2839 ++++++++++++++++++++
 7 files changed, 3159 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/marvell-armada-370-neta.txt
 create mode 100644 Documentation/devicetree/bindings/net/marvell-orion-mdio.txt
 create mode 100644 drivers/net/ethernet/marvell/mvmdio.c
 create mode 100644 drivers/net/ethernet/marvell/mvneta.c
