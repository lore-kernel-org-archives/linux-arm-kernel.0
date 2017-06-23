From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Fri, 23 Jun 2017 19:25:51 +0200
Subject: [GIT PULL] ARM: actions: dt for v4.13
In-Reply-To: <20170623172556.12618-1-afaerber@suse.de>
References: <20170623172556.12618-1-afaerber@suse.de>
Message-ID: <20170623172556.12618-2-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

This is the initial dt pull for Actions Semi.
The Kconfig symbol is introduced in the arm pull.

Regards,
Andreas

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-actions.git tags/actions-arm-dt-for-4.13

for you to fetch changes up to 740f6beb57b579ee69a3793dff1462a4020ec500:

  ARM: dts: owl-s500: Add SPS node (2017-06-19 18:36:44 +0200)

----------------------------------------------------------------
Actions Semi ARM based SoC DT for v4.13

This adds an initial DT for the S500 SoC and a devboard based on it.

----------------------------------------------------------------
Andreas F?rber (8):
      dt-bindings: Add vendor prefix for Actions Semi
      dt-bindings: arm: Document Actions Semi S500
      dt-bindings: timer: Document Owl timer
      dt-bindings: arm: Document Actions Semi S900
      ARM: dts: Add Actions Semi S500 and LeMaker Guitar
      dt-bindings: arm: cpus: Add S500 enable-method
      ARM: dts: owl-s500: Set CPU enable-method
      ARM: dts: owl-s500: Add SPS node

 Documentation/devicetree/bindings/arm/actions.txt  |  39 +++++
 Documentation/devicetree/bindings/arm/cpus.txt     |   1 +
 .../bindings/timer/actions,owl-timer.txt           |  20 +++
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/owl-s500-guitar-bb-rev-b.dts     |  26 +++
 arch/arm/boot/dts/owl-s500-guitar.dtsi             |  22 +++
 arch/arm/boot/dts/owl-s500.dtsi                    | 186 +++++++++++++++++++++
 8 files changed, 297 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/actions.txt
 create mode 100644 Documentation/devicetree/bindings/timer/actions,owl-timer.txt
 create mode 100644 arch/arm/boot/dts/owl-s500-guitar-bb-rev-b.dts
 create mode 100644 arch/arm/boot/dts/owl-s500-guitar.dtsi
 create mode 100644 arch/arm/boot/dts/owl-s500.dtsi
