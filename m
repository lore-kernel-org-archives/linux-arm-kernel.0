From: tony@atomide.com (Tony Lindgren)
Date: Tue, 30 Oct 2012 09:27:28 -0700
Subject: OMAP baseline test results for v3.7-rc3
In-Reply-To: <508FE8BA.1080404@ti.com>
References: <alpine.DEB.2.00.1210300229590.12697@utopia.booyaka.com>
 <508FB226.20604@mimc.co.uk>
 <alpine.DEB.2.00.1210301143420.12697@utopia.booyaka.com>
 <79CD15C6BA57404B839C016229A409A83EB51E84@DBDE01.ent.ti.com>
 <508FE8BA.1080404@ti.com>
Message-ID: <20121030162727.GG11908@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Vaibhav Hiremath <hvaibhav@ti.com> [121030 07:50]:
> > 
> > MMC is dependent on EDMA-DMA conversion patches from Matt, which he has 
> > already submitted to the list recently. So MMC support will come along with
> > EDMA support. DMA-EDMA patches are targeted for v3.8, lets see how it goes.

This is a bogus dependency, the MMC driver needs to also work
without DMA.

Regards,

Tony
