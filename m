From: dhylands@gmail.com (Dave Hylands)
Date: Thu, 14 Jul 2011 23:03:17 -0700
Subject: ARM cortex A9 feature
In-Reply-To: <CAJ8eaTyqOBq2mbfvuTun=bVvhFSrMqJ5uVyd+cozF5PtVeSVaw@mail.gmail.com>
References: <CAJ8eaTzLmSTSMOY-0Xg0tE-DEbZ6RNA+uh70Dn3K5CbrjQsEiA@mail.gmail.com>
	<CABi1daHh7cgyhJ4c3zo+jSUY4uzbFtihtgw0Q2Mcrndno_gcTA@mail.gmail.com>
	<CAJ8eaTyqOBq2mbfvuTun=bVvhFSrMqJ5uVyd+cozF5PtVeSVaw@mail.gmail.com>
Message-ID: <CABi1daFp=mKw0kq=Vm_T9RKeHfnXsA-kssdRm56AhkaJ4FjCxA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi naveen,

On Thu, Jul 14, 2011 at 10:15 PM, naveen yadav <yad.naveen@gmail.com> wrote:
> Hi dave,
>
> Thanks for answering, but I think question 2, answer ?is still not clear to me .
>
> my question is why exclusive L2.
>
> 8.1.4 Exclusive L2 cache
> The Cortex-A9 processor can be connected to an L2 cache that supports
> an exclusive cache
> mode. This mode must be activated both in the Cortex-A9 processor and
> in the L2 cache
> controller.
> In this mode, the data cache of the Cortex-A9 processor and the L2
> cache are exclusive. At any
> time, a given address is cached in either L1 data caches or in the L2
> cache, but not in both. This
> has the effect of greatly increasing the usable space and efficiency
> of an L2 cache connected to
> the Cortex-A9 processor. When exclusive cache configuration is selected:
> ? Data cache line replacement policy is modified so that the victim
> line always gets evicted
> to L2 memory, even if it is clean.
> ? If a line is dirty in the L2 cache controller, a read request to this address
>
>
> what is usecase for this . This is my question .

Since I've never used one, I'm not sure. Maybe somebody else knows.

-- 
Dave Hylands
Shuswap, BC, Canada
http://www.davehylands.com
