From: vaibhav.bedia@ti.com (Bedia, Vaibhav)
Date: Thu, 28 Jun 2012 15:27:06 +0000
Subject: how to specify dma_mask and coherent_dma_mask in hwmod
In-Reply-To: <EB1619762EAF8B4E97A227FB77B7E0293E9BDE96@DBDE01.ent.ti.com>
References: <EB1619762EAF8B4E97A227FB77B7E0293E9BDE96@DBDE01.ent.ti.com>
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EAED507@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+Paul, Benoit and Kevin

On Wed, Jun 27, 2012 at 11:11:32, N, Mugunthan V wrote:
> > -----Original Message-----
> > From: N, Mugunthan V
> > Sent: Thursday, June 07, 2012 9:52 PM
> > To: 'linux-omap at vger.kernel.org'
> > Cc: 'linux-arm-kernel at lists.infradead.org'
> > Subject: how to specify dma_mask and coherent_dma_mask in hwmod
> > 
> > Hi
> > 
> > While converting platform device registry to Hwmod for CPSW Ethernet
> > driver which is present in AM335X (OMAP2+), I am not finding a way to
> > specify
> > dma_mask and coherent_dma_mask.
> > Is there a way to specify dma_mask and coherent_dma_mask in hwmod?
> 
> Ping, any one has comment on this?

Right now there's no way of doing this in hwmod. But is omap_hwmod
the right place for this? It would help if you could describe why
the hwmod conversion is causing trouble for you.

Regards,
Vaibhav B.
