From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 25 May 2011 11:11:27 -0700
Subject: [PATCH 0/5] ARMv6 and ARMv7 mm fixes
In-Reply-To: <002f01cc1ada$5e7ffaa0$1b7fefe0$@deacon@arm.com>
References: <1305890399-29075-1-git-send-email-will.deacon@arm.com>
	<4DDC2A59.8030109@codeaurora.org>
	<002f01cc1ada$5e7ffaa0$1b7fefe0$@deacon@arm.com>
Message-ID: <4DDD464F.2010508@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/25/2011 05:50 AM, Will Deacon wrote:
> I was planning to CC stable for patches 1 ("ARM: cache: ensure MVA is cacheline
> aligned in flush_kern_dcache_area") and 4 ("ARM: mm: fix racy ASID rollover
> broadcast on SMP platforms") as these affect existing v6 and v7 cores. The
> remainder of the patches, although nice to have, only kick in on A15 as far as
> I'm aware (due to aggressive caching of speculative level 1 entries).

Would it be appropriate to reorder the series then so patches 1 and 4
come first?

> I was hoping for some acks/tested-bys before then since these changes affect a
> lot of platforms and the code is fairly scary.

Yes the patches look scary. I could give it a test on MSM but I'm not
even sure that will help much. Why didn't you Cc Russell on these patches?

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
