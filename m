From: vichy.kuo@gmail.com (vichy)
Date: Sun, 8 Mar 2015 20:31:45 +0800
Subject: some question about Set bit 22 in the PL310 (cache controller)
 AuxCtlr register
Message-ID: <CAOVJa8Euj-VC-r0uQdyxqRtU7v23t3UW=wWTbrTCz_6gSp4x6g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi all:
Recently we bumped into the same issue like below path:
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-April/245908.html
http://lists.infradead.org/pipermail/linux-arm-kernel/2010-November/031810.html

We have some question about this patch:
a. Under what circumstances, there will be memory returned by
dma_alloc_coherent and friends mapped as normal, cacheable mappings?

b. why "with CMA enabled, it should be safe not to set this bit."

Sincerely appreciate your kind help,
