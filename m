From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 20 Jun 2013 22:08:11 +0900
Subject: [GIT PULL 0/3] Renesas ARM-based SoC DT updates for v3.11 #2
Message-ID: <1371733694-27368-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Arnd,

This pull request is based on renesas-dt-for-v3.11 which you have
previously pulled.

The following changes since commit 24603f3caf07f5f65aa17ed7851ad4741595cf6a:

  ARM: shmobile: marzen-reference: add irqpin support in DT (2013-06-04 18:05:59 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt2-for-v3.11

for you to fetch changes up to c4fa4946f177ae214523586cd794ac18d34b1430:

  ARM: shmobile: irqpin: add a DT property to enable masking on parent (2013-06-19 21:27:31 +0900)

----------------------------------------------------------------
Second Round of Renesas ARM-based SoC DT updates for v3.11

* Increased DT coverage for renesas-intc-irqpin
  by Guennadi Liakhovetski
* Clean up of address format used in sh73a0 dtsi file
  by Guennadi Liakhovetski

----------------------------------------------------------------
Guennadi Liakhovetski (3):
      irqchip: renesas-intc-irqpin: DT binding for sense bitfield width
      ARM: shmobile: sh73a0: remove "0x" prefix from DT node names
      ARM: shmobile: irqpin: add a DT property to enable masking on parent

 .../interrupt-controller/renesas,intc-irqpin.txt       | 16 ++++++++++++++++
 arch/arm/boot/dts/sh73a0.dtsi                          | 18 +++++++++---------
 drivers/irqchip/irq-renesas-intc-irqpin.c              |  9 ++++++++-
 3 files changed, 33 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/renesas,intc-irqpin.txt
