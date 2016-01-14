From: Leonid.Yegoshin@imgtec.com (Leonid Yegoshin)
Date: Thu, 14 Jan 2016 12:12:53 -0800
Subject: [v3,11/41] mips: reuse asm-generic/barrier.h
In-Reply-To: <20160114120445.GB15828@arm.com>
References: <56945366.2090504@imgtec.com>
 <20160112092711.GP6344@twins.programming.kicks-ass.net>
 <20160112102555.GV6373@twins.programming.kicks-ass.net>
 <20160112104012.GW6373@twins.programming.kicks-ass.net>
 <20160112114111.GB15737@arm.com> <569565DA.2010903@imgtec.com>
 <20160113104516.GE25458@arm.com> <56969F4B.7070001@imgtec.com>
 <20160113204844.GV6357@twins.programming.kicks-ass.net>
 <5696BA6E.4070508@imgtec.com> <20160114120445.GB15828@arm.com>
Message-ID: <56980145.5030901@imgtec.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/14/2016 04:04 AM, Will Deacon wrote:
> Consequently, it's important that the architecture back-ends implement 
> these portable primitives (e.g. smp_mb()) in a way that satisfies the 
> kernel memory model so that core code doesn't need to worry about the 
> underlying architecture for synchronisation purposes.

It seems you don't listen me. I said multiple times - MIPS 
implementation of SYNC_RMB/SYNC_WMB/SYNC_MB/SYNC_ACQUIRE/SYNC_RELEASE 
instructions matches the description of 
smp_rmb/smp_wmb/smp_mb/sync_acquire/sync_release from 
Documentation/memory-barriers.txt file.

What else do you want from me - RTL or microArch design for that?

- Leonid.
