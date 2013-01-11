From: gang.chen@asianux.com (Chen Gang)
Date: Fri, 11 Jan 2013 19:24:21 +0800
Subject: [PATCH] arch/arm/plat-omap: initializing dma_lch_count, before
 judging omap_dma_reserve_channels
In-Reply-To: <50EFBEB3.4080207@ti.com>
References: <50EE9815.2080402@asianux.com> <50EE9C87.6060407@ti.com>
 <50EF9D11.6050801@asianux.com> <50EFBEB3.4080207@ti.com>
Message-ID: <50EFF665.9050607@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2013?01?11? 15:26, Santosh Shilimkar ??:
> On Friday 11 January 2013 10:33 AM, Chen Gang wrote:
>> ?? 2013??01??10?? 18:48, Santosh Shilimkar ???:
>>> 'omap_dma_reserve_channels' when used is suppose to be from command
>>> line. Hence the proposed fix in the review is the right one.
>>
>>    ok, thank you for your suggestion.
>>
>>    I will send patch v2, also mark you as Signed-of-by.
>>
> Acked-by: is just fine.
> 
> 
> 
  thanks, I have send patch v2 for it, since it is a new subject, so
still use [PATCH] instead of [PATCH v2].

  the subject of the new patch (which has sent) is:
    [PATCH] ARM: OMAP: Fix the use of uninitialized dma_lch_count

  please check, thanks.

-- 
Chen Gang

Asianux Corporation
