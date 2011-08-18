From: Hiroshi.DOYU@nokia.com (Hiroshi DOYU)
Date: Thu, 18 Aug 2011 13:50:46 +0300 (EEST)
Subject: [PATCH 0/7] omap: iommu migration, relocation and cleanups
In-Reply-To: <201108181112.55592.laurent.pinchart@ideasonboard.com>
References: <1313622608-30397-1-git-send-email-ohad@wizery.com>
	<201108181112.55592.laurent.pinchart@ideasonboard.com>
Message-ID: <20110818.135046.3757848928175252.Hiroshi.DOYU@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ohad,

From: ext Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 0/7] omap: iommu migration, relocation and cleanups
Date: Thu, 18 Aug 2011 11:12:55 +0200

> Hi Ohad,
> 
> On Thursday 18 August 2011 01:10:01 Ohad Ben-Cohen wrote:
>> 1. Migrate OMAP's iommu driver to the generic IOMMU API, and move it
>> to the dedicated iommu folder.
>> 
>> 2. Fix omap3isp appropriately so it doesn't break.
>> 
>> 3. Adapt OMAP's iovmm appropriately as well, because omap3isp still relies
>> on it. The plan is eventually to remove iovmm and replace it with the
>> upcoming IOMMU-based generic DMA-API. Move iovmm to the iommu folder too;
>> it belongs there more than it belongs in the OMAP folders.
>> 
>> 4. Start cleaning up OMAP's iommu components towards the end goal, where
>>     1) omap-iommu no longer exports public API (and instead provides its
>>        entire functionality via the generic IOMMU API).
>>     2) omap-iovmm is removed.

Good migration path!

>> Changes:
>> 1. Migrate iommu, iovmm and omap3isp in a single patch for bisectibility
>> sake.
>> 2. Apply Laurent Pinchart's comments (thanks Laurent!)
> 
> You're welcome.
> 
>> 3. Rebase to 3.1-rc2
> 
> For the OMAP3 ISP driver changes,
> 
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

For the rest of omap iommu/iovmm patches, they look good:

Acked-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
