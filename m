From: hunold@linuxtv.org (Michael Hunold)
Date: Fri, 02 Mar 2012 14:12:20 +0100
Subject: iMX53 quick start board and SATA
Message-ID: <4F50C734.90302@linuxtv.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello all,

I am trying to setup a iMX53 quick start board. This is my first
encounter with Freescale, so please bear with me.

I used the Code Sourcery arm-2011.03 toolchain and a stock Linux 3.2.8
kernel. I used "mx5_defconfig" and selected support for the "LOCO"
board, nothing more.

I have used other kernels as well, for example linux-linaro-3.1
(http://git.linaro.org/gitweb?p=kernel/linux-linaro-3.1.git;a=summary)
but with the same results.

>From the U-Boot bootloader I can access the SATA controller just fine.

But from the Linux side, there is zero evidence that the SATA controller
is recognised.

I have searched back and forth through the Linux kernel config, various
(Git) kernel trees around, Google, whatever. I have not found a
definitive answer about SATA support unfortunately.

I must be missing something fairly obvious.

Can somebody please confirm that SATA is supported on the iMX53 quick
start board using some kind of recent kernel?

If so, can you please point my to a tree that has this working?

If it should be working with the trees I have used, does anybody know
which config option I have missed?

Thanks and best regards
Michael.
