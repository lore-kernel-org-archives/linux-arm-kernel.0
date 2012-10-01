From: kernel.jason@gmail.com (Jason Lin)
Date: Mon, 1 Oct 2012 11:50:45 +0800
Subject: [RFC] arm/mm: add a protection when flushing anonymous pages
In-Reply-To: <CAGCDX1mY4wbMq4qDJ9vCazShxdWQXVYyWkpLd5u8_xqbEC2BWQ@mail.gmail.com>
References: <CAGCDX1mY4wbMq4qDJ9vCazShxdWQXVYyWkpLd5u8_xqbEC2BWQ@mail.gmail.com>
Message-ID: <CAGCDX1mkPVre6h=9kNbRqCp_wtbOneuRLMXM+mkZWFXPwWkBfg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear all:
By the way, I used the CPU with VIPT cache.
Thanks.

2012/10/1 Jason Lin <kernel.jason@gmail.com>:
> Dear all:
> When I do LTP direct I/O tests, it produced a cache coherence issue
> caused by flush_pfn_alias() (arch/arm/mm/flush.c).
> I think we should to disable preemption or lock before setting page
> table and enable preemption or unlock after flushing pages
>
> Any comments are appreciated.
> Thanks.
