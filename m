From: b-cousson@ti.com (Cousson, Benoit)
Date: Fri, 2 Nov 2012 09:50:23 +0100
Subject: [PATCH v2 1/2] ARM: OMAP: hwmod: Add possibility to count hwmod
 resources based on type
In-Reply-To: <509374A4.8050806@ti.com>
References: <1351596296-13825-1-git-send-email-peter.ujfalusi@ti.com>
 <1351596296-13825-2-git-send-email-peter.ujfalusi@ti.com>
 <509106FD.2040804@ti.com> <509374A4.8050806@ti.com>
Message-ID: <5093894F.7040300@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Salut P?ter,

On 11/2/2012 8:22 AM, P?ter Ujfalusi wrote:
> Hi Benoit,
>
> On 10/31/2012 12:09 PM, Cousson, Benoit wrote:
>> Hi Peter,
>>
>> That's great you've have done that fix.
>>
>> On 10/30/2012 12:24 PM, Peter Ujfalusi wrote:
>>> Add flags parameter for omap_hwmod_count_resources() so users can tell which
>>> type of resources they are interested when counting them in hwmod database.
>>
>> Mmm, does it worth doing that for every resources considering that this is a
>> temporary situation and than only the DMA resources are an issue so far?
>
> I think it is better to have nice API - even for a short term - than introduce
> a new wrapper just to count the DMA resources.
> Yes we only use this to either count all resources or to count the DMA
> resources only, but the other options does not look better either:
> 1. omap_hwmod_count_dma_resources(struct omap_hwmod *oh)
> 2. omap_hwmod_count_resources(struct omap_hwmod *oh, bool dma_only)

Fair enough. I'm OK with that. I'll take theses patches, except if Paul 
already have a 3.8 branch for hwmod.

Regards,
Benoit
