From: will.deacon@arm.com (Will Deacon)
Date: Fri, 5 Oct 2012 10:16:24 +0100
Subject: [PATCH] arm: include linux/sched.h in syscall.h
In-Reply-To: <20121004230957.GC4625@n2100.arm.linux.org.uk>
References: <5069F8A0.5020801@mentor.com>
 <20121002122124.GB11278@mudshark.cambridge.arm.com>
 <506B0BB0.5060707@mentor.com>
 <20121002155255.GJ11278@mudshark.cambridge.arm.com>
 <20121004230957.GC4625@n2100.arm.linux.org.uk>
Message-ID: <20121005091624.GB16044@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 05, 2012 at 12:09:57AM +0100, Russell King - ARM Linux wrote:
> On Tue, Oct 02, 2012 at 04:52:55PM +0100, Will Deacon wrote:
> > 
> > Yep, thanks. Your patch sounds like the right thing to do, but please
> > include the compiler error in your commit log.
> > 
> > Acked-by: Will Deacon <will.deacon@arm.com>
> 
> From what I can tell, the original commit went in during the 3.4..3.5
> timeframe, so doesn't this patch need to be applied to v3.5-stable
> as well as 3.6-stable and for 3.7 ?

I guess so, although it only seems to be affecting lttng which is still
out-of-tree. Depends how kind you're feeling!

Will
