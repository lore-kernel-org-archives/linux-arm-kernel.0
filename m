From: h-kanigeri2@ti.com (Kanigeri, Hari)
Date: Wed, 30 Jun 2010 13:44:14 -0500
Subject: [PATCH 22/33] Removing dead MPU_{BRIDGE,TESLA}_IOMMU
In-Reply-To: <20100630.212346.226780589.Hiroshi.DOYU@nokia.com>
References: <cover.1277911345.git.siccegge@cs.fau.de>
	<fcfa44a43c21c70f89ced96b96d7c1489d28cc51.1277911346.git.siccegge@cs.fau.de>
	<20100630.212346.226780589.Hiroshi.DOYU@nokia.com>
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E4CA55915@dlee03.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> -----Original Message-----
> From: Hiroshi DOYU [mailto:Hiroshi.DOYU at nokia.com]
> Sent: Wednesday, June 30, 2010 1:24 PM
> To: siccegge at cs.fau.de; Kanigeri, Hari
> Cc: tony at atomide.com; linux at arm.linux.org.uk; linux-omap at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org;
> vamos at i4.informatik.uni-erlangen.de
> Subject: Re: [PATCH 22/33] Removing dead MPU_{BRIDGE,TESLA}_IOMMU
> 
> From: ext Christoph Egger <siccegge@cs.fau.de>
> Subject: [PATCH 22/33] Removing dead MPU_{BRIDGE,TESLA}_IOMMU
> Date: Wed, 30 Jun 2010 18:01:01 +0200
> 
> > MPU_{BRIDGE,TESLA}_IOMMU doesn't exist in Kconfig, therefore removing
> > all references for it from the source code.
> 
> Coming soon, I guess. Hari?

Coming soon for both Bridge and Tesla. As I am writing this email, Fernando is preparing the Bridge patches to migrate to iommu.

Thank you,
Best regards,
Hari
