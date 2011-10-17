From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 17 Oct 2011 16:07:27 +0200
Subject: [Linaro-mm-sig] [PATCH 1/2] ARM: initial proof-of-concept IOMMU
	mapper for DMA-mapping
In-Reply-To: <401E54CE964CD94BAE1EB4A729C7087E3722519EAE@HQMAIL04.nvidia.com>
References: <1314971786-15140-1-git-send-email-m.szyprowski@samsung.com>
	<1314971786-15140-2-git-send-email-m.szyprowski@samsung.com>
	<594816116217195c28de13accaf1f9f2.squirrel@www.codeaurora.org>
	<001f01cc786d$d55222c0$7ff66840$%szyprowski@samsung.com>
	<401E54CE964CD94BAE1EB4A729C7087E37225197F8@HQMAIL04.nvidia.com>
	<00b101cc87ee$8976c410$9c644c30$%szyprowski@samsung.com>
	<401E54CE964CD94BAE1EB4A729C7087E3722519A1F@HQMAIL04.nvidia.com>
	<401E54CE964CD94BAE1EB4A729C7087E3722519BF4@HQMAIL04.nvidia.com>
	<00e501cc88a2$b82fc680$288f5380$%szyprowski@samsung.com>
	<401E54CE964CD94BAE1EB4A729C7087E3722519C65@HQMAIL04.nvidia.com>
	<401E54CE964CD94BAE1EB4A729C7087E3722519EAE@HQMAIL04.nvidia.com>
Message-ID: <01b801cc8cd6$1a6d4340$4f47c9c0$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krishna,

On Thursday, October 13, 2011 2:18 AM You wrote:

> Here a patch v2 that has updates/fixes to DMA IOMMU code. With these changes, the nvidia
> device is able to boot with all its platform drivers as DMA IOMMU clients.
> 
> Here is the overview of changes.
> 
> 1. Converted the mutex to spinlock to handle atomic context calls and used spinlock in
> necessary places.
> 2. Implemented arm_iommu_map_page and arm_iommu_unmap_page, which are used by MMC host stack.
> 3. Separated creation of dma_iommu_mapping from arm_iommu_attach_device in order to share
> mapping.
> 4. Fixed various bugs identified in DMA IOMMU code during testing.

The code looks much better now. The only problem is the fact that your mailed has changed
all tabs into spaces making the patch really hard to apply. Could you resend it correctly?

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
