From: dinguyen@kernel.org (Dinh Nguyen)
Date: Fri,  3 Feb 2017 09:22:02 -0600
Subject: [GIT PULL] SoCFPGA DTS updates for v4.11, part 2
Message-ID: <1486135322-7041-1-git-send-email-dinguyen@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, and Olof:

Please pull in these DTS updates for v4.11.

Thanks,
Dinh


The following changes since commit 7f0f5460d46867a8f980683136a054cff1357780:

  ARM: dts: socfpga: add missing compatible string for SDRAM controller (2017-01-06 01:42:06 -0600)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git tags/socfpga_dts_for_v4.11_part_2

for you to fetch changes up to cda1ade6a25c85d0a7cc2001a96b0b20f6bfd3f0:

  ARM: dts: Add EMAC AXI settings for Arria10 (2017-02-02 21:33:47 -0600)

----------------------------------------------------------------
SoCFPGA DTS updates for v4.11, part 2
- Add AXI configuration for DWMAC ethernet controllers on Arria10
- Use watchdog1 instead of watchdog0 on Arria10

----------------------------------------------------------------
Dinh Nguyen (1):
      ARM: dts: watchdog0 cannot reliably trigger reset

Thor Thayer (1):
      ARM: dts: Add EMAC AXI settings for Arria10

 arch/arm/boot/dts/socfpga_arria10.dtsi       | 9 +++++++++
 arch/arm/boot/dts/socfpga_arria10_socdk.dtsi | 2 +-
 2 files changed, 10 insertions(+), 1 deletion(-)
