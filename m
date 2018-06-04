From: will.deacon@arm.com (Will Deacon)
Date: Mon, 4 Jun 2018 10:04:22 +0100
Subject: [PATCH v2 0/9] Rewrite asm-generic/bitops/{atomic,lock}.h and
 use on arm64
In-Reply-To: <20180604074029.GN12217@hirez.programming.kicks-ass.net>
References: <1527869189-31512-1-git-send-email-will.deacon@arm.com>
 <20180604074029.GN12217@hirez.programming.kicks-ass.net>
Message-ID: <20180604090421.GA9482@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 04, 2018 at 09:40:29AM +0200, Peter Zijlstra wrote:
> On Fri, Jun 01, 2018 at 05:06:20PM +0100, Will Deacon wrote:
> > Hi all,
> > 
> > This patch series has previously been posted in RFC form here:
> > 
> >   RFCv1: https://www.spinics.net/lists/arm-kernel/msg634719.html
> >   RFCv2: https://www.spinics.net/lists/arm-kernel/msg636875.html
> >      v1: https://www.spinics.net/lists/arm-kernel/msg655262.html
> > 
> > The only change since v1 is that some of the fetch ops are replaced
> > by non-value-returning ops for some of the atomic bitops.
> > 
> 
> Looks good,
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Thanks, Peter!

> How do you want to route this, through tip or the arm64 tree?

I think -tip would make the most sense, if that's ok with Ingo.

Cheers,

Will
