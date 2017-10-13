From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 13 Oct 2017 21:54:47 +0200
Subject: [PATCH 0/4] ipmmu-vmsa cleanup
In-Reply-To: <cover.1507918320.git.robin.murphy@arm.com>
References: <cover.1507918320.git.robin.murphy@arm.com>
Message-ID: <CAK8P3a2oCaFuuAuLVaVnepryKDKFzemK8CO9W+dTZSpmvzxQhw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 13, 2017 at 8:23 PM, Robin Murphy <robin.murphy@arm.com> wrote:
> Arnd reports a build warning[1] thanks to me missing ipmmu-vmsa's second
> set of ops when converting io-pgtable-arm users to the new iommu_iotlb_*
> callbacks. Rather than just treat the symptom with a point fix, this
> seemed like a good excuse to clean up the messy #ifdeffery and
> duplication in the driver that led to the oversight in the first place.
>
> Build-tested successfully for arm64, ARM, and ARM + CONFIG_IOMMU_DMA.

Very nice. I looked over the patches and while I only understood half of
what you do and why it was different to start with, I very much welcome
the end result.

       Arnd
