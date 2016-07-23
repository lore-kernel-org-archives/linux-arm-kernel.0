From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Sat, 23 Jul 2016 10:10:52 -0400
Subject: [PATCH 0/3] ARM: fix three implicit module use cases fed via gpio
In-Reply-To: <8737n022tr.fsf@belgarion.home>
References: <20160720041332.30789-1-paul.gortmaker@windriver.com>
 <8737n022tr.fsf@belgarion.home>
Message-ID: <20160723141051.GB12632@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Re: [PATCH 0/3] ARM: fix three implicit module use cases fed via gpio] On 23/07/2016 (Sat 10:09) Robert Jarzmik wrote:

> Paul Gortmaker <paul.gortmaker@windriver.com> writes:
> 

[...]

> >
> > But with ARM and GPIO being different subsystems, we'll need to get
> > this in ARM 1st, and then wait a release before changing the GPIO
> > header, otherwise we'll risk triggering these three build failures.
> >
> > So, if folks consider these three trivial changes OK for late in the
> > for-4.8 cycle, then great.  Otherwise I'll resubmit the ARM parts for
> > for-4.9 and the GPIO bits for the one after that.

[...]

> Hi Paul,
> 
> I'll take the mach-pxa changes to pxa/for-next tree with Linus's ack.
> Tony, I think you will carry the remaining omap2 one, right ?
> 
> As for the cycle, I'd prefer have it for-4.9 as we're at rc7 and it's a bit late
> for me. If you want your GPIO bits to get in 4.9 I think I can commit to request
> pull very early (-rc1 time) or give my ack so that Linus can carry these changes
> through the gpio tree with the other changes.

Yep, agreed it is now (Sat) a bit late, so as per what I said above, do
whatever you are comfortable with and I'll react accordingly to make
sure the gpio fix lands on a baseline with all the other three patches
present and doesn't introduce build regressions.

Thanks,
Paul.

> 
> Cheers.
> 
> -- 
> Robert
