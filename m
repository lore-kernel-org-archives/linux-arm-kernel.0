From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Fri, 16 Dec 2011 02:47:26 +0200
Subject: [PATCH v4 3/4] OMAP3/4: iommu: migrate to hwmod framework
In-Reply-To: <1323922709-6986-4-git-send-email-omar.ramirez@ti.com>
References: <1323922709-6986-1-git-send-email-omar.ramirez@ti.com>
 <1323922709-6986-4-git-send-email-omar.ramirez@ti.com>
Message-ID: <CAMP44s13G3JVD41a5aaYc8xB_oikmH9Csres91qhc9yP2RhfEg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 15, 2011 at 6:18 AM, Omar Ramirez Luna <omar.ramirez@ti.com> wrote:
> Use hwmod data and device attributes to build and register an
> omap device for iommu driver.
>
> ?- Update the naming convention in isp module.
> ?- Remove unneeded check for number of resources, as this is now
> ? handled by omap_device and prevents driver from loading.
> ?- Now unused, remove platform device and resource data, handling
> ? of sysconfig register for softreset purposes, use default
> ? latency structure.

Looks good to me.

-- 
Felipe Contreras
