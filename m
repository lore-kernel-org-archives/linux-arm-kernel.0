From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 26 Feb 2014 11:12:04 +0100
Subject: build error on 3.14-rc4 with SPLIT_PTLOCK_CPUS <= NR_CPUS and !MMU
Message-ID: <20140226101204.GD6865@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

with the attached config building on v3.14-rc4 fails with 

In file included from arch/arm/kernel/asm-offsets.c:14:0:
include/linux/mm.h: In function 'pte_lockptr':
include/linux/mm.h:1392:2: error: implicit declaration of function 'pmd_page' [-Werror=implicit-function-declaration]
include/linux/mm.h:1392:2: warning: passing argument 1 of 'ptlock_ptr' makes pointer from integer without a cast [enabled by default]
include/linux/mm.h:1384:27: note: expected 'struct page *' but argument is of type 'int'

I don't know how to fix that.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
