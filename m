From: vaibhav.bedia@ti.com (Bedia, Vaibhav)
Date: Thu, 28 Jun 2012 16:42:07 +0000
Subject: how to specify dma_mask and coherent_dma_mask in hwmod
In-Reply-To: <alpine.DEB.2.00.1206281031510.2338@utopia.booyaka.com>
References: <EB1619762EAF8B4E97A227FB77B7E0293E9BDE96@DBDE01.ent.ti.com>
 <B5906170F1614E41A8A28DE3B8D121433EAED507@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1206280950440.2338@utopia.booyaka.com>
 <B5906170F1614E41A8A28DE3B8D121433EAED713@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1206281031510.2338@utopia.booyaka.com>
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EAED75F@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 28, 2012 at 22:02:46, Paul Walmsley wrote:
> On Thu, 28 Jun 2012, Bedia, Vaibhav wrote:
> 
> > On Thu, Jun 28, 2012 at 21:22:54, Paul Walmsley wrote:
> > [...]
> > > 
> > > dma_mask and coherent_dma_mask can be specified during 
> > > device creation.  See usb_musb_init() in arch/arm/mach-omap2/usb-musb.c 
> > > for an example.
> > > 
> > 
> > Thanks for pointing this out. Should omap_device_build() start handling this
> > or would that be an overkill?
> 
> If both dma_mask and coherent_dma_mask are always 0xffffffff on all OMAPs 
> and we can set that safely even for devices that don't use it, then yeah 
> it sounds like we should set it.
> 

I guess that's the case here also.
 
> Care to send a patch?
> 

Sure. Let me check with Mugunthan once.

Regards,
Vaibhav B.
