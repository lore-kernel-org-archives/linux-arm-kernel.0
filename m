From: dinh.linux@gmail.com (Dinh Nguyen)
Date: Tue,  8 Dec 2015 16:33:01 -0600
Subject: [GIT PULL] SoCFPGA DTS updates for v4.5
Message-ID: <1449613982-25888-1-git-send-email-dinh.linux@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, and Olof:

Please consider pulling this patch for v4.5.

Thanks,
Dinh

The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:

  Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git socfpga_dts_for_v4.5

for you to fetch changes up to 34a315883f60344f2116dcd445388531d09dc066:

  ARM: socfpga: Add support for DENX MCV SoM and MCVEVK baseboard (2015-11-19 10:15:05 -0600)

----------------------------------------------------------------
SoCFPGA DTS update for v4.5
- Add DT board file for Denx MCVEVK board

----------------------------------------------------------------
Marek Vasut (1):
      ARM: socfpga: Add support for DENX MCV SoM and MCVEVK baseboard

 arch/arm/boot/dts/Makefile                    |  1 +
 arch/arm/boot/dts/socfpga_cyclone5_mcv.dtsi   | 33 ++++++++++
 arch/arm/boot/dts/socfpga_cyclone5_mcvevk.dts | 94 +++++++++++++++++++++++++++
 3 files changed, 128 insertions(+)
 create mode 100644 arch/arm/boot/dts/socfpga_cyclone5_mcv.dtsi
 create mode 100644 arch/arm/boot/dts/socfpga_cyclone5_mcvevk.dts
