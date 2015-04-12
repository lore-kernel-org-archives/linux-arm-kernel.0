From: sophian.yoma@gmail.com (yoma sophian)
Date: Sun, 12 Apr 2015 20:23:59 +0800
Subject: how to mapping device memory in head.S
Message-ID: <CADUS3onGVjDd3Mquda2bgeLFvmxZUUYdiwzJ4nd7XjhyyudiDw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi all:
I need to map peripheral address in head.S for early usage.
And I found in arm/kernel/head.S, there is  CONFIG_DEBUG_LL for
mapping low level uart.
My questions are:
1. CONFIG_DEBUG_LL is  using short-descriptor 1st-level section
descriptor formats. Is it possible to use short-descriptor 2nd-level
small page descriptor in head.S?
2. The peripheral mapping virtual address created in head.S is need to
access even after paging_init. Is it possible to put the mapping in
the persistent mapping in head.S?

appreciate your kind help in advance,
