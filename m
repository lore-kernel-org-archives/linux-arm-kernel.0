From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 31 Jan 2017 02:13:03 +0900
Subject: [PATCH 0/2] ARM: cache-uniphier: two cleanup patches
Message-ID: <1485796385-22000-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry that I had not replied earlier.
I came back to this finally.
I guess we were seeing different code base the last time.

This seems correct to me, so I'd like to put it
in Russell's patch tracker.



Masahiro Yamada (2):
  ARM: cache-uniphier: include <linux/errno.h> instead of
    <linux/types.h>
  ARM: cache-uniphier: clean up active way setup code

 arch/arm/include/asm/hardware/cache-uniphier.h |  2 +-
 arch/arm/mm/cache-uniphier.c                   | 23 +++++++++--------------
 2 files changed, 10 insertions(+), 15 deletions(-)

-- 
2.7.4
