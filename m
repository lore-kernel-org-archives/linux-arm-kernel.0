From: tony@atomide.com (Tony Lindgren)
Date: Wed, 26 Feb 2014 09:15:35 -0800
Subject: [PATCHv2 08/16] ARM: OMAP3: remove deprecated
 CONFIG_OMAP_IOMMU_IVA2
In-Reply-To: <1488816.z8hE0Kk16e@avalon>
References: <1392315347-32967-1-git-send-email-s-anna@ti.com>
 <1392315347-32967-9-git-send-email-s-anna@ti.com>
 <1488816.z8hE0Kk16e@avalon>
Message-ID: <20140226171534.GF11654@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Laurent Pinchart <laurent.pinchart@ideasonboard.com> [140225 13:18]:
> On Thursday 13 February 2014 12:15:39 Suman Anna wrote:
> > From: Florian Vaussard <florian.vaussard@epfl.ch>
> > 
> > CONFIG_OMAP_IOMMU_IVA2 was defined originally to avoid conflicting
> > usage by tidspbridge and other iommu users. The same can be achieved
> > by marking the DT node disabled, so remove this obsolete flag and
> > the corresponding hwmod data can be enabled.
> > 
> > Cc: Paul Walmsley <paul@pwsan.com>
> > Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
> > [s-anna at ti.com: revise commit log]
> > Signed-off-by: Suman Anna <s-anna@ti.com>
> 
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Acked-by: Tony Lindgren <tony@atomide.com>
