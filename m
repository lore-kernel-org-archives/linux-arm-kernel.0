From: eric@anholt.net (Eric Anholt)
Date: Tue, 21 Mar 2017 12:39:49 -0700
Subject: [GIT PULL 1/4] bcm2835 arm DT updates for 4.12
Message-ID: <20170321193952.10270-1-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  git://github.com/anholt/linux tags/bcm2835-dt-next-2017-03-21

for you to fetch changes up to 7f31a955a0c34de0463f7ff50b2bd62a5cce4204:

  ARM: dts: bcm2835: add sdhost controller to devicetree (2017-03-17 17:35:50 -0700)

----------------------------------------------------------------
This pull request brings in the DT nodes for enabling HDMI audio on
Raspberry Pi, and nodes to describe the DSI and SDHOST hardware
modules (which are still disabled by default).

----------------------------------------------------------------
Boris Brezillon (1):
      ARM: dts: bcm283x: Add HDMI audio related properties

Eric Anholt (1):
      ARM: dts: bcm2835: Add the DSI module nodes and clocks.

Gerd Hoffmann (1):
      ARM: dts: bcm2835: add sdhost controller to devicetree

 arch/arm/boot/dts/bcm2835-rpi.dtsi | 14 +++++++++
 arch/arm/boot/dts/bcm283x.dtsi     | 60 ++++++++++++++++++++++++++++++++++++--
 2 files changed, 71 insertions(+), 3 deletions(-)
