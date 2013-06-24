From: balbi@ti.com (Felipe Balbi)
Date: Mon, 24 Jun 2013 22:34:03 +0300
Subject: [PATCH v7 0/9] Generic PHY Framework
In-Reply-To: <51C89D98.1070806@samsung.com>
References: <1371113039-5784-1-git-send-email-kishon@ti.com>
 <51BEE203.6090103@samsung.com>
 <20130618094942.GY5461@arwen.pp.htv.fi>
 <51C89D98.1070806@samsung.com>
Message-ID: <20130624193403.GB11815@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 24, 2013 at 09:27:20PM +0200, Sylwester Nawrocki wrote:
> Hi,
> 
> On 06/18/2013 11:49 AM, Felipe Balbi wrote:
> > On Mon, Jun 17, 2013 at 12:16:35PM +0200, Sylwester Nawrocki wrote:
> >> I have already used this API for our MIPI CSI-2/DSIM DPHYs driver,
> >> the RFC patch series can be found at [1].
> >>
> >> Thanks,
> >> Sylwester
> >>
> >> [1] http://www.spinics.net/lists/arm-kernel/msg251666.html
> > 
> > one comment to that series:
> > 
> > let's make the phy names standardized, how about phy-exynos-video-mipi.c
> > or phy-mipi-csi-dsim.c ?
> 
> Yes, I have been thinking about that, wasn't sure exactly what pattern to
> chose. I would make it phy-exynos-mipi-video.c, phy-exynos-dsim-csis.c feels
> a bit odd. phy-mipi-csis-dsim.c might be to generic as MIPI CSIS stands for
> MIPI CSI Slave and MIPI DSIM - MIPI DSI Master. And there might be (actually
> are) IP blocks in an SoC that use the other MIPI Aliance standards.
> For the HDMI PHY I guess just phy-exynos-hdmi.c could be used.

sounds good to me :-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130624/c4b283e8/attachment.sig>
