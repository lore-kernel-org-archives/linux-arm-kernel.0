From: Joerg.Roedel@amd.com (Roedel, Joerg)
Date: Tue, 15 Nov 2011 11:39:26 +0100
Subject: [RFC 0/5] OMAP groundwork for IOMMU-based DMA API
In-Reply-To: <1316948337-7924-1-git-send-email-ohad@wizery.com>
References: <1316948337-7924-1-git-send-email-ohad@wizery.com>
Message-ID: <20111115103926.GA5627@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ohad,

On Sun, Sep 25, 2011 at 06:58:52AM -0400, Ohad Ben-Cohen wrote:
> Ohad Ben-Cohen (5):
>   ARM: dev_archdata: add private iommu extension
>   ARM: OMAP: omap_device: add a method to set iommu private archdata
>   ARM: OMAP: iommu: declare a private iommu binding struct
>   ARM: OMAP3: bind omap3isp_device to its iommu device
>   iommu/omap: eliminate the public omap_find_iommu_device() method

It doesn't apply cleanly, can you please rebase the code, collect the
Acked-by's and resend?

Thanks,

	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
