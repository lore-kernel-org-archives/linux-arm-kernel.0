From: hashim.kernel@gmail.com (hashim alig)
Date: Tue, 28 Sep 2010 18:55:11 +0530
Subject: High Latency in PL310 L2 cache maintenance operations
Message-ID: <AANLkTinMYZmzy=J1TOEPs6dKs2gCwzazECop_riK2nwd@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
I am using linux-2.6.32 kernel on a platform which is ARM-Cortex A9
SMP (dual core, each at 500 MHz) with PL310 as the L2 cache. I observe
high latency in cache maintainance operations (both invalidation and
clean) which is around 90 cycles for every cache line (32 bytes).
Is it normal? What should be the practical range ?
I also tried with linux-2.6.35 over which I applied few L2 patches
from Catalin but observation remains same.

regards
Hashim
