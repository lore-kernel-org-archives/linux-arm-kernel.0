From: hunold@linuxtv.org (Michael Hunold)
Date: Wed, 29 Feb 2012 12:53:01 +0100
Subject: iMX53 quick start board and SD/MMC
Message-ID: <4F4E119D.7020104@linuxtv.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello all,

I am trying to setup a iMX53 quick start board. This is my first
encounter with Freescale, so please bear with me.

I used the Code Sourcery arm-2011.03 toolchain and a stock Linux 3.2.8
kernel. I used "imx_v4_v5_defconfig" and selected support for the "LOCO"
board, nothing more.

For the root filesystem I used a stock buildroot-2011.11. For the
beginning, I boot the system using NFS root filesystem.

The board boots just fine, but the SD/MMC card slot(s) are not
recognised by the kernel.

I see mxcmci_init() is getting called, but not the probe routine. Did I
miss anything important?

Can somebody confirm that the board works with stock Linux 3.2.8 kernel
at all?

I noticed that "imx-sdma imx35-sdma: firmware not found" is printed on
the console. I understand that the iMX53 has a special DMA engine, but
is it necessary for the SD/MMC card slots to function?

If so, where is the official source for the necessary firmware?

Thanks and best regards
Michael.
