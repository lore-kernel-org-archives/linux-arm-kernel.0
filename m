From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 2 Mar 2016 17:05:22 +0100
Subject: [GIT PULL] at91: dt for 4.6 #2
Message-ID: <1456934722-7023-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

A second batch of DT updates for 4.6. This time it is based on 4.5-rc3 as one
of the patches fixes an node that was changed during 4.5-rc phase. As I saw
that your "next/dt" branches are based on 4.5-rc3, I thought it wouldn't be a
problem.
Overall a pretty simple series with mainly node addition for the latest SoC
and its Xplained board.
The tag doesn't embed Alexandre's previous DT Pull-Request for 4.6 that was
based on 4.5-rc1. I verified though that  it doesn't conflict with it during a
merge.

Thanks, best regards,

The following changes since commit 388f7b1d6e8ca06762e2454d28d6c3c55ad0fe95:

  Linux 4.5-rc3 (2016-02-07 15:38:30 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git tags/at91-dt2

for you to fetch changes up to ed0f4b3ffcdbd2b47a0b24035bb6f22464c9fef1:

  ARM: dts: at91: sama5d2 Xplained: add leds node (2016-03-02 16:55:37 +0100)

----------------------------------------------------------------
Second 4.6 DT series, all patches for sama5d2 and its Xplained board:
- addition of the NAND flash node
- addition of the dma properties for UART/USART nodes
- one update of the sama5d2 Xplained phy node
- addition of USB pinmux, button and leds

----------------------------------------------------------------
Cyrille Pitchen (1):
      ARM: dts: at91: sama5d2 Xplained: set pin muxing for usb gadget and usb host

Ludovic Desroches (1):
      ARM: dts: at91: sama5d2 Xplained: add user push button

Nicolas Ferre (1):
      ARM: dts: at91: sama5d2: add dma properties to UART nodes

Romain Izard (2):
      ARM: dts: at91: sama5d2 Xplained: Correct the macb irq pinctrl node
      ARM: dts: at91: sama5d2: add nand0 and nfc0 nodes

Wenyou Yang (1):
      ARM: dts: at91: sama5d2 Xplained: add leds node

 arch/arm/boot/dts/at91-sama5d2_xplained.dts | 70 +++++++++++++++++++++++++++
 arch/arm/boot/dts/sama5d2.dtsi              | 73 +++++++++++++++++++++++++++++
 2 files changed, 143 insertions(+)

-- 
Nicolas Ferre
