From: pullip.cho@samsung.com (KyongHo Cho)
Date: Fri, 18 Nov 2011 19:19:53 +0900
Subject: [PATCH 0/3] ARM: iommu: tegra: Add initial Tegra IOMMU driver
In-Reply-To: <1321527667-12923-1-git-send-email-hdoyu@nvidia.com>
References: <1321527667-12923-1-git-send-email-hdoyu@nvidia.com>
Message-ID: <CAHQjnOM-N9suPrv_nSRQsxGCNrf77rFLNtRcOdsjyz_O6bGdpA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 17, 2011 at 8:01 PM,  <hdoyu@nvidia.com> wrote:
>
> Hiroshi DOYU (3):
> ?ARM: iommu: tegra/common: Initial support for IOVMM driver
> ?ARM: iommu: tegra2: Initial support for GART driver
> ?ARM: iommu: tegra3: Initial support for SMMU driver
>

Hi.

I found that those patches are not IOMMU API implementations.
I wonder why they need to be located in drivers/iommu?

Regards,

  KyongHo
