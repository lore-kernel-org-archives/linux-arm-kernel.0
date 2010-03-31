From: hjk@linutronix.de (Hans J. Koch)
Date: Wed, 31 Mar 2010 16:45:44 +0200
Subject: [PATCH 0/7 v4] Add basic support for Telechips TCC8xxx SoCs
Message-ID: <20100331144543.GA2035@bluebox.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'll reply to this mail with a series of 7 patches that add basic support
for Telechips TCC8xxx SoCs. It also adds support for Telechips' TCC8000-SDK
board. Drivers for UART, MMC, USB host + gadget, and NAND are also available.
I'll post these in a second step.

This is version 4 of this patch series. There were no more issues found in
the review of the last version. Anyway, I made the following changes:

- Removed the lines disabled with #if 0 I accidentally had left in the last
  version.
- Some minor coding style changes to make checkpatch.pl happy.
- One minor change in a commit message.
- Rebased against 2.6.34-rc3.

Russell, I can set up a for-rmk branch in a git repository. Simply tell me
to do so if you prefer to pull from git (and you consider the review process
finished, of course).

Thanks,
Hans
