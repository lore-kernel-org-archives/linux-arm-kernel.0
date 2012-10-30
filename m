From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Tue, 30 Oct 2012 12:39:33 +0000
Subject: OMAP baseline test results for v3.7-rc3
In-Reply-To: <alpine.DEB.2.00.1210301143420.12697@utopia.booyaka.com>
References: <alpine.DEB.2.00.1210300229590.12697@utopia.booyaka.com>
 <508FB226.20604@mimc.co.uk>
 <alpine.DEB.2.00.1210301143420.12697@utopia.booyaka.com>
Message-ID: <79CD15C6BA57404B839C016229A409A83EB51E84@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 30, 2012 at 17:17:00, Paul Walmsley wrote:
> cc Vaibhav Hiremath
> 
> On Tue, 30 Oct 2012, Mark Jackson wrote:
> 
> > At what point is booting from MMC on the BeagleBone going to start working ?
> > 
> > I only ask, since, by default, a new BeagleBone is setup to boot from 
> > MMC, so anyone testing a new kernel will probably expect the same setup 
> > to work.
> 
> BeagleBone boots initramfs from MMC now, which is what mine was shipped to 
> do.  Are you asking about rootfs on MMC?  If so, Vaibhav would have a 
> better sense of this than I.
> 

Mark,

MMC is dependent on EDMA-DMA conversion patches from Matt, which he has 
already submitted to the list recently. So MMC support will come along with
EDMA support. DMA-EDMA patches are targeted for v3.8, lets see how it goes.


If you refer to the Matt's repo, you should get all the patches required to 
boot MMC support -

https://github.com/ohporter/linux/tree/edma-dmaengine-am33xx-v3



Thanks,
Vaibhav
