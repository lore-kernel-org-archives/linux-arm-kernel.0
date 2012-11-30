From: pgaikwad@nvidia.com (Prashant Gaikwad)
Date: Fri, 30 Nov 2012 12:39:05 +0530
Subject: [PATCH 2/2] ARM: tegra: moving stuff away from mach/clk.h
In-Reply-To: <50B7A87E.5070302@wwwdotorg.org>
References: <1353999553-5196-1-git-send-email-sivaramn@nvidia.com>
 <1353999553-5196-2-git-send-email-sivaramn@nvidia.com>
 <50B6FCE5.7080003@nvidia.com> <50B7A87E.5070302@wwwdotorg.org>
Message-ID: <50B85B91.6080802@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 29 November 2012 11:55 PM, Stephen Warren wrote:
> On 11/28/2012 11:12 PM, Prashant Gaikwad wrote:
>> On Tuesday 27 November 2012 12:29 PM, Sivaram Nair wrote:
>>> This patch moves some stuff away from mach/clk.h to other mach-tegra
>>> files. This is part of the efforts to get rid of mach/clk.h which in
>>> turn will help to enable single zImage.
>>>
>>> Signed-off-by: Sivaram Nair <sivaramn@nvidia.com>
>>> ---
>>>    arch/arm/mach-tegra/clock.c            |    1 +
>>>    arch/arm/mach-tegra/clock.h            |   12 ++++++++++--
>>>    arch/arm/mach-tegra/include/mach/clk.h |   11 -----------
>>>    3 files changed, 11 insertions(+), 13 deletions(-)
>> This patch will not add any real value since I have removed clk_cfg_ex
>> functionality in clock code rework.
>> It's just that I will have to rebase my changes on this.
>>
>> Reviewed-by: Prashant Gaikwad <pgaikwad@nvidia.com>
> In that case, I may as well not apply patch 2/2 at all, and I'll just
> take your clock code cleanup instead. I assume that will be posted for
> inclusion into 3.9?

Yes, I am targeting for 3.9.

> --
> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
