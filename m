From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Tue, 23 Oct 2012 10:12:29 +0000
Subject: Fwd: [PATCH 2/5] ARM: OMAP3+: hwmod: Add AM33XX HWMOD data for
 davinci_mdio
In-Reply-To: <20121019061630.GB2983@netboy.at.omicron.at>
References: <20121017181354.GA2412@netboy.at.omicron.at>
 <alpine.DEB.2.00.1210172337170.30902@utopia.booyaka.com>
 <20121017235045.GB30550@atomide.com>
 <20121018030654.GE2867@netboy.at.omicron.at>
 <alpine.DEB.2.00.1210180313360.6893@utopia.booyaka.com>
 <20121018184443.GD2350@netboy.at.omicron.at> <50806B1D.9040504@ti.com>
 <20121019061630.GB2983@netboy.at.omicron.at>
Message-ID: <79CD15C6BA57404B839C016229A409A83EB48592@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 19, 2012 at 11:46:30, Richard Cochran wrote:
> On Fri, Oct 19, 2012 at 02:18:29AM +0530, Vaibhav Hiremath wrote:
> > 
> > Another important point is, this driver is also required and used for
> > Davinci family of devices (arch/mach/mach-davinci/).
> 
> That is really beside the point. If the code isn't ready yet, then
> don't merge it.
> 

With respect to AM33xx the driver may not be ready, but that doesn't mean 
driver itself is not ready. As I mentioned before, driver is used on davinci 
platform and it could be functional there. 

In case of AM33xx, where DT only boot mode is supported, you are forced to 
migrate driver to DT, which is addition to the driver.

Note that, all the patches you have posted recently are AM33xx SoC 
integration specific patches.

> When I asked about the beaglebone, I was given the impression that it
> will be ready for v3.7-rc1.  But, as I know realize, at the current
> rate, it might not even be ready for v3.8.
> 

I understand, and as you mentioned we are not fully there at v3.7-rc1 with 
all the drivers/module support, due to all known reasons. Its good that with 
v3.7-rc2, Beaglebone boots up out of box from mainline. 


Thanks,
Vaibhav
> I don't mind waiting, but please make sure that whatever lands into a
> release is really, truly working.
> 
> Thanks,
> Richard
> 
> 
> 
