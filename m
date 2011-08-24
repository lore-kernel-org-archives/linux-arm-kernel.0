From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 24 Aug 2011 12:10:29 +0200
Subject: [GIT PULL] at91: fixes for 3.1
Message-ID: <4E54CE15.1020504@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Can you please pull this "fixes" patch since commit fcb8ce5cfe30ca9ca5c9a79cdfe26d1993e65e0c:

  Linux 3.1-rc3 (2011-08-22 11:42:53 -0700)

It is available in the git repository at:
  git://github.com/at91linux/linux-2.6-at91.git at91-fixes

Jean-Christophe PLAGNIOL-VILLARD (1):
      at91: at91sam9261.c: fix typo in t2_clk alias for atmel_tcb.0

 arch/arm/mach-at91/at91sam9261.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

It is a single patch but I prefer to send you a 
pull request as it may integrate better with your
flow...

Thanks a lot, bye,
-- 
Nicolas Ferre
