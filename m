From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 4 Apr 2013 20:04:08 +0530
Subject: [PATCH v2 00/18] ARM: OMAP5: PM: Add MPUSS suspend and CPUidle
 support
In-Reply-To: <87hajnp6ph.fsf@linaro.org>
References: <1364205910-32392-1-git-send-email-santosh.shilimkar@ti.com>
 <87hajnp6ph.fsf@linaro.org>
Message-ID: <515D8F60.1080603@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 04 April 2013 04:22 AM, Kevin Hilman wrote:
> Hi Santosh,
> 
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
> 
>> Here is the refreshed version(v2) of the OMAP5 PM suspport which was posted
>> earlier (March 1st 2013). Patch-set incorporates comments from Nishant
>> Menon (Thanks for review NM) and his acked-by tags. I would like to get this
>> queued for 3.10 merge window if you are ok with the series.
> 
> I did a review of this series with several comments on the individual
> patches.  
> 
Thanks a lot Kevin. I have addressed all the comments and have
updated patches ready.

> I've already queued most of the CPUidle fixes/cleanups in my
> for_3.10/cleanup/cpuidle branch and will get that to Tony soon.  For the
> rest, I suggest probably breaking it up into cleanup/consolidation stuff
> and then OMAP5 support.  The latter will depend on all the OMAP5
> data/headers but the cleanup/consolidation stuff could be merged sooner
> (but probably a bit late for v3.10 now.)
> 
I have already split the patch-set into 'consolidation' and 'OMAP5
support' since it was straight forward. Need to just build the
branches on top of your branches. So waiting for you to update
your 'for_3.10/*' branches.

For the merge, its your call:)
As you said OMAP5 support(couple of patches) has a dependency
on OMAP5 data files. I will at least make the branches ready on
top of yours.

Regards,
Santosh
