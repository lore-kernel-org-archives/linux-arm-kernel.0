From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Wed, 31 Oct 2012 13:57:02 +0000
Subject: OMAP baseline test results for v3.7-rc3
In-Reply-To: <50912A6F.1040501@mimc.co.uk>
References: <alpine.DEB.2.00.1210300229590.12697@utopia.booyaka.com>
 <508FB226.20604@mimc.co.uk>
 <alpine.DEB.2.00.1210301143420.12697@utopia.booyaka.com>
 <79CD15C6BA57404B839C016229A409A83EB51E84@DBDE01.ent.ti.com>
 <508FE8BA.1080404@ti.com> <50912A6F.1040501@mimc.co.uk>
Message-ID: <79CD15C6BA57404B839C016229A409A83EB563F8@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 31, 2012 at 19:11:03, Mark Jackson wrote:
> On 30/10/12 14:48, Vaibhav Hiremath wrote:
> > 
> > 
> > On 10/30/2012 6:09 PM, Hiremath, Vaibhav wrote:
> >>
> >> Mark,
> >>
> >> MMC is dependent on EDMA-DMA conversion patches from Matt, which he has 
> >> already submitted to the list recently. So MMC support will come along with
> >> EDMA support. DMA-EDMA patches are targeted for v3.8, lets see how it goes.
> >>
> >>
> >> If you refer to the Matt's repo, you should get all the patches required to 
> >> boot MMC support -
> >>
> >> https://github.com/ohporter/linux/tree/edma-dmaengine-am33xx-v3
> >>
> >>
> > 
> > I just tested this branch (+ one fix which Matt provided [1]) on
> > BeagleBone, and MMC is working without any issues. I have tested with
> > rootFS on MMC card.
> > 
> > 
> > [1] - http://www.spinics.net/lists/linux-omap/msg79911.html
> 
> Okay, so I'm now coming up against a brick wall regarding U-Boot.
> 
> The Kernel boots fine (as per the tree + patch above) provided I build U-Boot using the
> v2011.09_AM335xPSP_04.06.00.06 branch from git://arago-project.org/git/projects/u-boot-am33x.git
> 
> If I try the latest mainline U-Boot (or the TI branch), I just get to "Starting kernel ..." and then
> hangs.
> 
> I'm going to raise this query on the U-Boot ML, but can you let me know which U-Boot image you're
> using ?
> 


I am using Mainline u-boot and it works for me. Can you paste u-boot boot 
log and environment variable here?

Thanks,
Vaibhav

> Cheers
> Mark J.
> 
