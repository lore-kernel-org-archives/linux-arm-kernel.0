From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Thu, 27 Jun 2013 11:05:06 +0200 (CEST)
Subject: [linux-next PATCH] ARM: shmobile: marzen: defconfig: enable DMA
 engine support
In-Reply-To: <20130627050007.GF28229@verge.net.au>
References: <1642514.quKgForQrD@amdc1032> <20130626145252.GA4748@verge.net.au>
 <Pine.LNX.4.64.1306261700130.8856@axis700.grange>
 <20130627050007.GF28229@verge.net.au>
Message-ID: <Pine.LNX.4.64.1306271103470.19503@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 27 Jun 2013, Simon Horman wrote:

> On Wed, Jun 26, 2013 at 05:01:36PM +0200, Guennadi Liakhovetski wrote:
> > Hi
> > 
> > On Wed, 26 Jun 2013, Simon Horman wrote:
> > 
> > > [ Cc linux-sh and Guennadi ]
> > > 
> > > I have not looked into this closely but it seems to me that
> > > it would be more robust to resolve this problem using Kconfig.
> > 
> > I still think this
> > 
> > https://patchwork.kernel.org/patch/2640051/
> > 
> > is a proper fix. We cannot and do not want to force building shdma on all
> > platforms, where SDHI or any other potential shdma client is built. It is
> > perfectly valid to build SDHI with no DMA support, which is exactly what
> > that patch makes possible.
> 
> That is fine by me. Is there anything I can do to help move it forward?

Well, you could reply to that thread with your ack or something...

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
