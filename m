From: joro@8bytes.org (Joerg Roedel)
Date: Fri, 10 Feb 2017 14:59:08 +0100
Subject: [PATCH 10/11] iommu/exynos: Make use of iommu_device_register
 interface
In-Reply-To: <9a1997dd-5835-cb9a-6478-7fb276151e52@samsung.com>
References: <1486639981-32368-1-git-send-email-joro@8bytes.org>
 <CGME20170209113308epcas2p2cd79f382b04635bc7e973a62c093d557@epcas2p2.samsung.com>
 <1486639981-32368-11-git-send-email-joro@8bytes.org>
 <9a1997dd-5835-cb9a-6478-7fb276151e52@samsung.com>
Message-ID: <20170210135908.GH7339@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 10, 2017 at 02:46:59PM +0100, Marek Szyprowski wrote:
> Hi
> 
> On 2017-02-09 12:32, Joerg Roedel wrote:
> >From: Joerg Roedel <jroedel@suse.de>
> >
> >Register Exynos IOMMUs to the IOMMU core and make them
> >visible in sysfs. This patch does not add the links between
> >IOMMUs and translated devices yet.
> >
> >Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> >Cc: linux-arm-kernel at lists.infradead.org
> >Cc: linux-samsung-soc at vger.kernel.org
> >Signed-off-by: Joerg Roedel <jroedel@suse.de>
> 
> Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Thanks a lot for testing!
