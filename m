From: hjk@linutronix.de (Hans J. Koch)
Date: Mon, 22 Mar 2010 20:19:00 +0100
Subject: [PATCH 0/7] Add basic support for Telechips TCC8xxx SoCs
Message-ID: <20100322191900.GF2040@bluebox.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Telechips' TCC8xxx SoCs are ARM9-based processors, mainly for automotive and
multimedia applications. I'll reply to this mail with a series of 7 patches
that implement basic support for these chips.

These patches were tested on a Telechips-TCC8000-SDK development board.
Support for this board is also included.

I've also got drivers for some on-chip peripherals (UART, MMC, NAND, USB host
and gadget). I'll post these in a second step. Board support is already
prepared to use them.

@Russell: Do you want me to post the drivers on linux-arm-kernel, or on the
appropriate subsystem mailing list?

The whole tree is also available here:

git://git.linutronix.de/users/hjk/linux-tcc.git

The "devel" branch contains all I've got ATM, including experimental stuff not
yet ready for mainline. 

@Russell: As soon as the review process stabilizes, I can set up a "for-rmk"
branch, if that's what you wish.

Thanks,
Hans
