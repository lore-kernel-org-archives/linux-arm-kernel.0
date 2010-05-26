From: hjk@linutronix.de (Hans J. Koch)
Date: Wed, 26 May 2010 19:42:41 +0200
Subject: [PATCH 0/7 v6] Add basic support for Telechips TCC8xxx SoCs
Message-ID: <20100526174240.GC2006@bluebox.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'll reply to this mail with a series of 7 patches that add support for
Telechips TCC8xxx ARM9-based SoCs.

Changes since v5:

- Removed UART support and register definitions since the TCC8000 has
  8250-compatible UARTs built in. No need to reinvent the wheel.

- Fixed a wrong use of unreachable().

- Fixed a clock refcounting bug.

- Rebased against 2.6.34

Thanks,
Hans
