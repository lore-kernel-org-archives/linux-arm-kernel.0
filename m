From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 11 Jan 2013 12:56:43 +0530
Subject: [PATCH] arch/arm/plat-omap: initializing dma_lch_count, before
 judging omap_dma_reserve_channels
In-Reply-To: <50EF9D11.6050801@asianux.com>
References: <50EE9815.2080402@asianux.com> <50EE9C87.6060407@ti.com>
 <50EF9D11.6050801@asianux.com>
Message-ID: <50EFBEB3.4080207@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 11 January 2013 10:33 AM, Chen Gang wrote:
> ? 2013?01?10? 18:48, Santosh Shilimkar ??:
>> 'omap_dma_reserve_channels' when used is suppose to be from command
>> line. Hence the proposed fix in the review is the right one.
> 
>    ok, thank you for your suggestion.
> 
>    I will send patch v2, also mark you as Signed-of-by.
> 
Acked-by: is just fine.
