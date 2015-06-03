From: dinh.linux@gmail.com (dinh.linux at gmail.com)
Date: Tue,  2 Jun 2015 21:30:38 -0500
Subject: [GIT PULL] SoCFPGA DTS updates for v4.2, part 3
Message-ID: <1433298638-4159-1-git-send-email-dinh.linux@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof:

Please pull these patches for v4.2.

Thanks,
Dinh

The following changes since commit 030bbdbf4c833bc69f502eae58498bc5572db736:

  Linux 4.1-rc3 (2015-05-10 15:12:29 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git socfpga_dts_for_v4.2_part_3

for you to fetch changes up to e0e6f74801e1d027fa172d47b3e2515027f4728e:

  ARM: socfpga: socrates: add gpio-leds (2015-06-02 14:27:11 -0500)

----------------------------------------------------------------
SoCFPGA updates for v4.2 part 3
- Add SCU node for Arria 10
- Add enable-method for cpu nodes
- Add SDRAM controller binding doc
- Enable gpio-leds on SoCFPGA Socrates board

----------------------------------------------------------------
Alan Tull (1):
      ARM: socfpga: dts: add sdram controller dt binding doc

Dinh Nguyen (2):
      ARM: socfpga: dts: add the a9-scu node for arria10
      ARM: socfpga: dts: add enable-method property for cpu nodes

Steffen Trumtrar (2):
      ARM: socfpga: socrates: enable gpio0/1
      ARM: socfpga: socrates: add gpio-leds

 .../arm/altera/socfpga-sdram-controller.txt        | 12 +++++++++
 arch/arm/boot/dts/socfpga.dtsi                     |  1 +
 arch/arm/boot/dts/socfpga_arria10.dtsi             |  6 +++++
 arch/arm/boot/dts/socfpga_cyclone5_socrates.dts    | 31 ++++++++++++++++++++++
 4 files changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/altera/socfpga-sdram-controller.txt
