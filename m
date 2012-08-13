From: will.deacon@arm.com (Will Deacon)
Date: Mon, 13 Aug 2012 15:11:57 +0100
Subject: RFC: mutex: hung tasks on SMP platforms with
 asm-generic/mutex-xchg.h
In-Reply-To: <1344866717.31459.32.camel@twins>
References: <20120807115647.GA12828@mudshark.cambridge.arm.com>
 <alpine.LFD.2.02.1208090029460.5231@xanadu.home>
 <20120809144953.GC18486@mudshark.cambridge.arm.com>
 <alpine.LFD.2.02.1208091201380.5231@xanadu.home>
 <alpine.LFD.2.02.1208091243080.5231@xanadu.home>
 <1344845704.31459.11.camel@twins>
 <alpine.LFD.2.02.1208130931530.5231@xanadu.home>
 <1344866717.31459.32.camel@twins>
Message-ID: <20120813141156.GC20537@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 13, 2012 at 03:05:17PM +0100, Peter Zijlstra wrote:
> Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>

Thanks Peter.

> Will you carry this through the ARM tree or do you want me/Ingo to take
> it?

Please can you guys take it? The move to mutex-dec can go through the ARM
tree but it's probably best if you take the core change.

Cheers,

Will
