From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 12 Feb 2013 17:15:01 +0000
Subject: [PATCH] HACK: ARM: Fix generic timer broadcast for TWD
In-Reply-To: <20130212171217.GB13775@e106331-lin.cambridge.arm.com>
References: <1360684194-10894-1-git-send-email-thierry.reding@avionic-design.de>
 <20130212155516.GP17833@n2100.arm.linux.org.uk>
 <20130212171217.GB13775@e106331-lin.cambridge.arm.com>
Message-ID: <20130212171501.GT17833@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 12, 2013 at 05:12:17PM +0000, Mark Rutland wrote:
> [...]
> 
> > So, things to be done here:
> > 1. Fix the #else part of the code.
> > 2. Fix the reported oops.
> 
> I believe the patch below solves point 1. Nothing refers to smp_timer_broadcast
> any more (as I've tested with git grep), so removing it shouldn't create any
> additional problems.
> 
> Russell, are you happy for me to drop this in the patch system?

Yes, it might as well go into the devel-stable branch along with your
other patches.  Thanks.
