From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 16 Jan 2015 11:33:40 +0100
Subject: [PATCH v3 00/19] Exynos SYSMMU (IOMMU) integration with DT and
 DMA-mapping subsystem
In-Reply-To: <1417514366.21830.22.camel@collabora.co.uk>
References: <1416395748-10731-1-git-send-email-m.szyprowski@samsung.com>
 <1417514366.21830.22.camel@collabora.co.uk>
Message-ID: <54B8E904.6090107@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 2014-12-02 10:59, Sjoerd Simons wrote:
> Hey Marek, Inki,
>
> On Wed, 2014-11-19 at 12:15 +0100, Marek Szyprowski wrote:
>> Hello Everyone,
>>
>> This is another attempt to finally make Exynos SYSMMU driver fully
>> integrated with DMA-mapping subsystem. The main change from previous
>> version is a rebase onto latest "automatic DMA configuration for IOMMU
>> masters" patches from Will Deacon.
> Do you happen to know if anyone is working on iommu/dma-mapping patches
> for Exynos 5 based on this patchset?

Just to let all of You know - I posted a new version of this patchset with
Exynos 5250 & 5420/5422/5800 DTS patches:

http://lists.linaro.org/pipermail/linaro-mm-sig/2015-January/004327.html

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
