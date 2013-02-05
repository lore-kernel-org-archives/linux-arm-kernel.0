From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 5 Feb 2013 11:20:14 +0100
Subject: [GIT PULL] at91: fixes for 3.9-rc1
Message-ID: <5110DCDE.1080403@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

As I realized reading Linus' email that it was not possible to queue more
fixes for 3.8, I took my time to send this tiny pull request. But now that
the merge window is approaching, I prefer not to wait for more material.
So, here is a "fixes" pull-request embedding a single patch. I have placed this
one on top of material that you already have from me in your "fixes" and
"for-next" branches.

The following changes since commit 7d4cfece23f535b60496d88a717a3d7bfca50187:

  ARM: at91/at91sam9x5.dtsi: fix usart3 TXD (2013-01-30 10:09:17 +0100)

are available in the git repository at:

  git://github.com/at91linux/linux-at91.git tags/at91-fixes

for you to fetch changes up to c3f0f282d950a1e87496a2633ed9e924e275ff8c:

  ARM: at91/DT: remove atmel,use-dma-* from 9x5 and 9n12 USART nodes (2013-02-05 10:55:11 +0100)

----------------------------------------------------------------
Correction of 9x5 and 9n12 USART nodes

----------------------------------------------------------------
Nicolas Ferre (1):
      ARM: at91/DT: remove atmel,use-dma-* from 9x5 and 9n12 USART nodes

 arch/arm/boot/dts/at91sam9n12.dtsi | 8 --------
 arch/arm/boot/dts/at91sam9x5.dtsi  | 6 ------
 2 files changed, 14 deletions(-)


Thanks, bye,
-- 
Nicolas Ferre
