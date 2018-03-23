From: dinguyen@kernel.org (Dinh Nguyen)
Date: Fri, 23 Mar 2018 14:54:43 -0500
Subject: [GIT PULL 1/2] SoCFPGA DTS updates for v4.17
Message-ID: <1521834884-23795-1-git-send-email-dinguyen@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, and Olof:

Please pull in these SoCFPGA Stratix10 DTS updates for v4.17.

Thanks,
Dinh

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git tags/socfpga_dts_for_v4.17

for you to fetch changes up to 6d97d5aba08b26108f95dc9fb7bbe4d9436c769c:

  arm: dts: socfpga: fix GIC PPI warning (2018-03-23 08:55:48 -0500)

----------------------------------------------------------------
SoCFPGA DTS updates for v4.17
- Fix GIC PPI warning
- Stratix10 platform updates
  - Disable over-current for Arria10 devkit
  - Enable watchdog timer

----------------------------------------------------------------
Dinh Nguyen (2):
      arm64: dts: stratix10: enable watchdog timer on the S10 devkit
      arm64: dts: stratix10: disable false USB overcurrent on devkit

Philipp Puschmann (1):
      arm: dts: socfpga: fix GIC PPI warning

 arch/arm/boot/dts/socfpga.dtsi                         | 2 +-
 arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)
