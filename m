From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Mon, 10 Nov 2014 11:27:53 +0000
Subject: [PATCH v2 0/2] arm64: Add support for Juno development board
Message-ID: <1415618875-8469-1-git-send-email-Liviu.Dudau@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Arnd and Kevin,

I have sent these patches a week ago but I have not properly addressed
them to you, so you might have missed them. The original submission is
here: http://lkml.org/lkml/2014/10/31/372.

Changes vs v1: Dropped the defconfig change that is now in mainline.

Please consider this series for addition to the arm-soc tree.

This patchset adds device tree support for ARM's AArch64 Juno development
board. It enables use of various peripherals on the board, from USB and
networking to I2C and PL011 UART.

The patches can also be found in the repository at:

   git://github.com/ARM-software/linux.git juno/dts-for-armsoc

for you to fetch.

Best regards,
Liviu

Liviu Dudau (2):
  arm64: Create link to include/dt-bindings to enable C preprocessor use.
  arm64: Add Juno SoC device tree.

 arch/arm64/boot/dts/Makefile            |   2 +-
 arch/arm64/boot/dts/include/dt-bindings |   1 +
 arch/arm64/boot/dts/juno.dts            | 374 ++++++++++++++++++++++++++++++++
 3 files changed, 376 insertions(+), 1 deletion(-)
 create mode 120000 arch/arm64/boot/dts/include/dt-bindings
 create mode 100644 arch/arm64/boot/dts/juno.dts

-- 
2.1.3
