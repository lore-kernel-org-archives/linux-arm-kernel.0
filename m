From: afaerber@suse.de (=?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?=)
Date: Tue, 19 Aug 2014 13:39:10 +0200
Subject: [PATCH 00/29] Exynos SYSMMU (IOMMU) integration with DT and
 DMA-mapping subsystem
In-Reply-To: <53F2E9AD.9030308@samsung.com>
References: <1407235677-26324-1-git-send-email-m.szyprowski@samsung.com>
 <20140818233201.GL9809@8bytes.org> <53F2E9AD.9030308@samsung.com>
Message-ID: <53F3375E.6030402@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek and Inki,

Am 19.08.2014 08:07, schrieb Marek Szyprowski:
> On 2014-08-19 01:32, Joerg Roedel wrote:
>> On Tue, Aug 05, 2014 at 12:47:28PM +0200, Marek Szyprowski wrote:
[...]
>>>   33 files changed, 1016 insertions(+), 356 deletions(-)
>> This touches a lot of non-iommu stuff. What is your strategy on getting
>> this in, do you plan to get the non-iommu changes merged first or do you
>> want to collect the respective Acks and merge this all through one tree?
> 
> Those patches are posted as one patchset mainly to demonstrate how to get
> everything to work together. I also posted this as a single patch series
> to get some feedback from other iommu developers, especially all those
> involved in the generic iommu dt bindings.
> 
> For merging, I will split them into smaller series and try to get
> respective acks.

I'm working on 5250 based Spring Chromebook and noticed that v3.17-rc1
got some more iommu support. With the new CONFIG_DRM_EXYNOS_IOMMU=y my
machine stops booting. So I'm wondering, is any of this a fix for 3.17,
or is all of this "unrelated" -next material? Also, are you or someone
working on the respective DT changes for Exynos5?

Regards,
Andreas

-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg
