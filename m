From: jiang.liu@linux.intel.com (Jiang Liu)
Date: Thu, 06 Nov 2014 21:35:21 +0800
Subject: [Patch Part2 v4 00/31] Enable hierarchy irqdomian on x86 platforms
In-Reply-To: <20141106130753.GN10744@8bytes.org>
References: <1415102525-9898-1-git-send-email-jiang.liu@linux.intel.com>
 <20141106130753.GN10744@8bytes.org>
Message-ID: <545B7919.2080002@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014/11/6 21:07, Joerg Roedel wrote:
> On Tue, Nov 04, 2014 at 08:01:34PM +0800, Jiang Liu wrote:
>> Patch 1-5 enhance irqdomain and irq core to support hierarchy irqdomain
>> and stacked irqchip.
>> Patch 6-12 implement an irqdomain to manange CPU interrupt vectors, and
>> it's the root irqdomain for x86 platforms.
>> Patch 13-16 converts Intel and AMD interrupt remapping drivers to
>> support hierarchy irqdomain.
>> Patch 17-23 converts HPET and MSI to support hierarchy irqdomain.
>> Patch 24-27 cleans up unsued code in x86 arch and interrupt remapping
>> drivers.
>> Patch 28-31 converts DMAR, HTIRQ and UV to support hierarchy irqdomain.
> 
> Okay, I looked over the IOMMU changes and did some testing. With Jiangs
> fix for the AMD Kaveri boot panic it looks good to me. So for the IOMMU
> parts:
> 
> Acked-by: Joerg Roedel <jroedel@suse.de>
Thanks, Joerg!

> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
