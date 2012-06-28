From: vaibhav.bedia@ti.com (Bedia, Vaibhav)
Date: Thu, 28 Jun 2012 16:31:22 +0000
Subject: how to specify dma_mask and coherent_dma_mask in hwmod
In-Reply-To: <alpine.DEB.2.00.1206280950440.2338@utopia.booyaka.com>
References: <EB1619762EAF8B4E97A227FB77B7E0293E9BDE96@DBDE01.ent.ti.com>
 <B5906170F1614E41A8A28DE3B8D121433EAED507@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1206280950440.2338@utopia.booyaka.com>
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EAED713@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On Thu, Jun 28, 2012 at 21:22:54, Paul Walmsley wrote:
[...]
> 
> dma_mask and coherent_dma_mask can be specified during 
> device creation.  See usb_musb_init() in arch/arm/mach-omap2/usb-musb.c 
> for an example.
> 

Thanks for pointing this out. Should omap_device_build() start handling this
or would that be an overkill?

Regards,
Vaibhav B.
