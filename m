From: mporter@linaro.org (Matt Porter)
Date: Mon, 28 Jul 2014 10:48:25 -0400
Subject: [GIT PULL] ARM: mach-bcm: dt updates for 3.17
Message-ID: <20140728144825.GA9030@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Please consider pulling the following mach-bcm dt updates for 3.16.

-Matt

The following changes since commit 9a3c4145af32125c5ee39c0272662b47307a8323:

  Linux 3.16-rc6 (2014-07-20 21:04:16 -0700)

are available in the git repository at:

  git://github.com/broadcom/mach-bcm tags/for-3.17/bcm-dt

for you to fetch changes up to 79187a8e242046a0525a296509e80c5ee24fbaf1:

  ARM: brcmstb: dts: add a reference DTS for Broadcom 7445 (2014-07-28 10:01:46 -0400)

----------------------------------------------------------------
ARM: mach-bcm: dt updatees for 3.17

- BCM Mobile SMP support
- BRCM STB platform support

----------------------------------------------------------------
Alex Elder (3):
      devicetree: bindings: document Broadcom CPU enable method
      ARM: dts: enable SMP support for bcm28155
      ARM: dts: enable SMP support for bcm21664

Marc Carino (4):
      ARM: brcmstb: add CPU binding for Broadcom Brahma15
      ARM: brcmstb: add misc. DT bindings for brcmstb
      ARM: brcmstb: gic: add compatible string for Broadcom Brahma15
      ARM: brcmstb: dts: add a reference DTS for Broadcom 7445

 .../bindings/arm/bcm/brcm,bcm11351-cpu-method      |  36 +++++++
 .../devicetree/bindings/arm/brcm-brcmstb.txt       |  95 ++++++++++++++++++
 Documentation/devicetree/bindings/arm/cpus.txt     |   2 +
 Documentation/devicetree/bindings/arm/gic.txt      |   1 +
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/bcm11351.dtsi                    |  19 ++++
 arch/arm/boot/dts/bcm21664.dtsi                    |  19 ++++
 arch/arm/boot/dts/bcm7445-bcm97445svmb.dts         |  14 +++
 arch/arm/boot/dts/bcm7445.dtsi                     | 111 +++++++++++++++++++++
 9 files changed, 299 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,bcm11351-cpu-method
 create mode 100644 Documentation/devicetree/bindings/arm/brcm-brcmstb.txt
 create mode 100644 arch/arm/boot/dts/bcm7445-bcm97445svmb.dts
 create mode 100644 arch/arm/boot/dts/bcm7445.dtsi
