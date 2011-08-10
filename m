From: will.deacon@arm.com (Will Deacon)
Date: Wed, 10 Aug 2011 14:05:21 +0100
Subject: [PATCH 2/2] ARM: perf: make name of arm_pmu_type consistent
In-Reply-To: <1312981138-17020-2-git-send-email-mark.rutland@arm.com>
References: <1312981138-17020-1-git-send-email-mark.rutland@arm.com>
	<1312981138-17020-2-git-send-email-mark.rutland@arm.com>
Message-ID: <20110810130521.GI10121@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark,

On Wed, Aug 10, 2011 at 01:58:58PM +0100, Mark Rutland wrote:
> Commit f12482c9 ("ARM: 6974/1: pmu: refactor reservation") changed
> {release,reserve}_pmu to take an enum arm_pmu_type as a parameter, but
> inconsistently named the parameter `type' or `device'. It would be nice
> if these were consistent.
> 
> This patch makes use of enum arm_pmu_type consistent, always using
> 'device' as this is more common in usage.

Thanks for fixing this. I'll take care of these two patches as fixes for
3.1.

Will
