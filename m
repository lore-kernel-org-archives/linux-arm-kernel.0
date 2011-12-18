From: joro@8bytes.org ('Joerg Roedel')
Date: Sun, 18 Dec 2011 19:02:59 +0100
Subject: [PATCH v7 0/2] iommu/exynos: Add IOMMU/System MMU driver for
 Samsung Exynos
In-Reply-To: <4EEE0F02.8070800@samsung.com>
References: <1321609650-1329-1-git-send-email-pullip.cho@samsung.com>
 <20111123114626.GH20535@8bytes.org>
 <045b01ccaffa$ef48c430$cdda4c90$%kim@samsung.com>
 <20111201185821.GL20535@8bytes.org>
 <04f601ccb0ce$72590550$570b0ff0$%kim@samsung.com>
 <20111202084922.GM20535@8bytes.org> <4EEE0F02.8070800@samsung.com>
Message-ID: <20111218180258.GD28302@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 19, 2011 at 01:04:18AM +0900, Kukjin Kim wrote:
> Hmm, I cannot find the iommu/exynos branch what you said in your iommu  
> tree yet. Maybe you missed or any problem?

Problems. I tried to apply the patches and there were conflicts. After
solving them I wasn't able to find a kernel-config for Exynos that
conpiled for upstream Linux.
Additionally new objections were raised about the patches. Enough to not
merge these patches at this point. When I have a config to at least
compile-test the code you send me and repost the patches rebased to a
recent upstream commit with the objections fixed I can retry to merge
it.


Thanks,

	Joerg
