From: dinguyen@kernel.org (Dinh Nguyen)
Date: Mon, 30 Oct 2017 09:42:49 -0500
Subject: [GIT PULL] SoCFPGA DTS updates for v4.15, part 2
Message-ID: <1509374569-5811-1-git-send-email-dinguyen@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, and Olof:

Please pull in these SoCFPGA Stratix10 DTS updates for v4.15.

Thanks,
Dinh


The following changes since commit 788251fa08118efa934ba2f54989997e7a5be679:

  arm64: dts: stratix10: add reset property for various peripherals (2017-09-21 09:16:50 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git tags/socfpga_dts_for_v4.15_part2

for you to fetch changes up to a067fb4290131b5b356dfcc464b5bff19a251791:

  arm64: dts: stratix10: fix interrupt number for gpio1 (2017-10-11 03:26:08 -0500)

----------------------------------------------------------------
SoCFPGA DTS updates for v4.15, part 2
- Stratix10 platform update
  - Enable GPIO and LEDs for Stratix10 devkit

----------------------------------------------------------------
Alan Tull (2):
      arm64: dts: stratix10: add gpio header
      arm64: dts: stratix10: enable gpio and leds

Dinh Nguyen (1):
      arm64: dts: stratix10: fix interrupt number for gpio1

 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi  |  3 ++-
 .../boot/dts/altera/socfpga_stratix10_socdk.dts    | 22 ++++++++++++++++++++++
 2 files changed, 24 insertions(+), 1 deletion(-)
