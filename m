From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Tue, 18 Dec 2012 10:34:12 +0100 (CET)
Subject: [PATCH 05/10] ARM: shmobile: Add DT table of INTC for sh7372
In-Reply-To: <20121218003717.GI7146@verge.net.au>
References: <1355562224-29448-1-git-send-email-horms+renesas@verge.net.au>
 <1355562224-29448-6-git-send-email-horms+renesas@verge.net.au>
 <Pine.LNX.4.64.1212170941400.24007@axis700.grange>
 <20121218003717.GI7146@verge.net.au>
Message-ID: <alpine.DEB.2.00.1212181032000.2949@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon

On Tue, 18 Dec 2012, Simon Horman wrote:

> On Mon, Dec 17, 2012 at 09:44:10AM +0100, Guennadi Liakhovetski wrote:
> > Hi Simon
> > 
> > On Sat, 15 Dec 2012, Simon Horman wrote:
> > 
> > > From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
> > > 
> > > Cc: Magnus Damm <damm@opensource.se>
> > > Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
> > > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > 
> > What happened to intcs support? Why has it been dropped? Without it many 
> > important devices cannot be set up from DT, e.g. I2C #0.
> 
> INTCS support is still being worked on and doesn't seem to be
> quite ready yet. I am aware that this limits the usefulness of
> this series. But it is a step in the right direction.

What are the problems with it? My patch series uses INTCS support from the 
previous version of this patch-set, so, now, without INTCS, I'll have to 
remove from .dts I2C0 and all devices on it.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
