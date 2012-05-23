From: will.deacon@arm.com (Will Deacon)
Date: Wed, 23 May 2012 18:05:29 +0100
Subject: perf_event_v7.c compilation failure in next-20120523
In-Reply-To: <4FBD1796.4030309@wwwdotorg.org>
References: <4FBD1796.4030309@wwwdotorg.org>
Message-ID: <20120523170528.GH26693@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 23, 2012 at 06:00:06PM +0100, Stephen Warren wrote:
> Will,
> 
> In next-20120523, the following two commits of yours collided:
> 
> d33c88c ARM: 7315/1: perf: add support for the Cortex-A7 PMU
> (adds new entry to perf_event_v7.c)
> 
> b3426c5 ARM: perf: remove arm_perf_pmu_ids global enumeration
> (removes a field from entries in perf_event_v7.c)

Cheers Stephen. The former commit is actually in 3.4, so I must've missed
it when rebasing yesterday.

I'll update my for-next branch.

Thanks,

Will
