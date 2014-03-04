From: s-anna@ti.com (Suman Anna)
Date: Tue, 4 Mar 2014 10:52:02 -0600
Subject: [PATCHv3 00/13] OMAP IOMMU DT adaptation for 3.15
In-Reply-To: <20140304160432.GG2799@8bytes.org>
References: <1393620164-14633-1-git-send-email-s-anna@ti.com>
 <20140228230000.GW13624@atomide.com> <20140304160432.GG2799@8bytes.org>
Message-ID: <531604B2.5080400@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/04/2014 10:04 AM, Joerg Roedel wrote:
> On Fri, Feb 28, 2014 at 03:00:00PM -0800, Tony Lindgren wrote:
>> * Suman Anna <s-anna@ti.com> [140228 12:46]:
>>> Hi Joerg, Tony,
>>>
>>> This is an updated series of the OMAP IOMMU DT adaptation intended
>>> for 3.15 merge window, addressing the comments from the v2 series.
>>> This series is rebased onto 3.14-rc4, and the only change to bindings
>>> is to drop the dma-window property.
>>>
>>> The first 7 patches in the series are in drivers/iommu, with the first
>>> 3 patches performing some cleanup. The DT bindings and adaptation are
>>> done in patches 4 and 5.
>>>
>>> Tony,
>>> Patches 8 through 13 are in arch/arm/mach-omap2 layer, so I am guessing
>>> these would have to go through your tree. Of these, patches 8 and 9 are
>>> cleanup fixes to get OMAP3 IVA MMU working, patches 10 & 11 are fixes
>>> required with DT-boot for OMAP3/4, patches 12 & 13 add the OMAP5 support.
>>
>> Are patches 8 to 13 OK to apply separately from the iommu patches or
>> do they need to wait for the iommu patches to get merged first?
>
> Applied patches 1-7 to my arm/omap branch.

Thanks, Joerg.

regards
Suman
