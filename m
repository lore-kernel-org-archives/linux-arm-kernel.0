From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 19 Nov 2012 15:26:59 +0100
Subject: [GIT PULL] Marvell DT updates for clk support in mvneta driver
Message-ID: <1353335221-26516-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason,

As said in my previous pull request (containing the clk support for
mvneta as well as the section mismatch fix), there are DT updates
needed related to the clk support. The two patches in this pull
request correspond to those DT updates, that should go in your
'mvebu/dt' branch I guess.

Thanks!

The following changes since commit 4b968e8f98603a422f35b18682c169fb706c0115:

  net: mvneta: fix section mismatch warning caused by mvneta_deinit() (2012-11-19 14:45:25 +0100)

are available in the git repository at:

  git at github.com:MISL-EBU-System-SW/mainline-public.git tags/marvell-neta-dt-clk-updates-3.8

for you to fetch changes up to 8a5bdfa8d8f381f384a088da2f06b8a35fca2742:

  arm: mvebu: remove 'clock-frequency' properties from Armada 370/XP Ethernet nodes (2012-11-19 14:45:26 +0100)

----------------------------------------------------------------
Marvell Ethernet DT update for clk support

----------------------------------------------------------------
Thomas Petazzoni (2):
      arm: mvebu: add 'clocks' property to Ethernet nodes for Armada 370/XP SoCs
      arm: mvebu: remove 'clock-frequency' properties from Armada 370/XP Ethernet nodes

 arch/arm/boot/dts/armada-370-db.dts              |    2 --
 arch/arm/boot/dts/armada-370-mirabox.dts         |    2 --
 arch/arm/boot/dts/armada-370-xp.dtsi             |    2 ++
 arch/arm/boot/dts/armada-xp-db.dts               |    4 ----
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts |    4 ----
 arch/arm/boot/dts/armada-xp.dtsi                 |    2 ++
 6 files changed, 4 insertions(+), 12 deletions(-)
