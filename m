From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 28 Sep 2010 15:49:18 +0100
Subject: High Latency in PL310 L2 cache maintenance operations
In-Reply-To: <AANLkTinMYZmzy=J1TOEPs6dKs2gCwzazECop_riK2nwd@mail.gmail.com>
References: <AANLkTinMYZmzy=J1TOEPs6dKs2gCwzazECop_riK2nwd@mail.gmail.com>
Message-ID: <1285685358.14312.1.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-09-28 at 14:25 +0100, hashim alig wrote:
> I am using linux-2.6.32 kernel on a platform which is ARM-Cortex A9
> SMP (dual core, each at 500 MHz) with PL310 as the L2 cache. I observe
> high latency in cache maintainance operations (both invalidation and
> clean) which is around 90 cycles for every cache line (32 bytes).
> Is it normal? What should be the practical range ?
> I also tried with linux-2.6.35 over which I applied few L2 patches
> from Catalin but observation remains same.

Have you applied this patch from Will Deacon:

http://www.linux-arm.org/git?p=linux-2.6-stable.git;a=commitdiff;h=c3d0fd52ce0c36836aefd53ce9b25f193daa2e5e

-- 
Catalin
