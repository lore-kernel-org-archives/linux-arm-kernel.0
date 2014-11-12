From: joro@8bytes.org (Joerg Roedel)
Date: Wed, 12 Nov 2014 15:21:50 +0100
Subject: [PATCH v6 05/12] memory: Add NVIDIA Tegra memory controller
 support
In-Reply-To: <1415376063-17205-6-git-send-email-thierry.reding@gmail.com>
References: <1415376063-17205-1-git-send-email-thierry.reding@gmail.com>
 <1415376063-17205-6-git-send-email-thierry.reding@gmail.com>
Message-ID: <20141112142150.GV10744@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 07, 2014 at 05:00:56PM +0100, Thierry Reding wrote:
>  drivers/iommu/tegra-smmu.c               | 1295 ------------------------------
>  drivers/memory/tegra/smmu.c              |  716 +++++++++++++++++

This new smmu.c is an IOMMU driver, why do you put it in drivers/memory
and not in drivers/iommu?


	Joerg
