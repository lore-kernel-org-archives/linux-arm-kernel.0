From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 27 Sep 2011 13:46:13 +0200
Subject: [RFC 5/5] iommu/omap: eliminate the public
	omap_find_iommu_device() method
In-Reply-To: <1316948337-7924-6-git-send-email-ohad@wizery.com>
References: <1316948337-7924-1-git-send-email-ohad@wizery.com>
	<1316948337-7924-6-git-send-email-ohad@wizery.com>
Message-ID: <201109271346.13791.laurent.pinchart@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ohad,

Thanks for the patch.

On Sunday 25 September 2011 12:58:57 Ohad Ben-Cohen wrote:
> Eliminate the public omap_find_iommu_device() method, and don't
> expect clients to provide the omap_iommu handle anymore.
> 
> Instead, OMAP's iommu driver should now utilize dev_archdata's private
> iommu extension to be able to access the required iommu information.
> 
> Update omap3isp appropriately.
> 
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
> Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Tony Lindgren <tony@atomide.com>

For the OMAP3 ISP driver,

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

-- 
Regards,

Laurent Pinchart
