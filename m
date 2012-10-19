From: richardcochran@gmail.com (Richard Cochran)
Date: Fri, 19 Oct 2012 08:16:30 +0200
Subject: Fwd: [PATCH 2/5] ARM: OMAP3+: hwmod: Add AM33XX HWMOD data for
 davinci_mdio
In-Reply-To: <50806B1D.9040504@ti.com>
References: <20121017181354.GA2412@netboy.at.omicron.at>
 <alpine.DEB.2.00.1210172337170.30902@utopia.booyaka.com>
 <20121017235045.GB30550@atomide.com>
 <20121018030654.GE2867@netboy.at.omicron.at>
 <alpine.DEB.2.00.1210180313360.6893@utopia.booyaka.com>
 <20121018184443.GD2350@netboy.at.omicron.at>
 <50806B1D.9040504@ti.com>
Message-ID: <20121019061630.GB2983@netboy.at.omicron.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 19, 2012 at 02:18:29AM +0530, Vaibhav Hiremath wrote:
> 
> Another important point is, this driver is also required and used for
> Davinci family of devices (arch/mach/mach-davinci/).

That is really beside the point. If the code isn't ready yet, then
don't merge it.

When I asked about the beaglebone, I was given the impression that it
will be ready for v3.7-rc1.  But, as I know realize, at the current
rate, it might not even be ready for v3.8.

I don't mind waiting, but please make sure that whatever lands into a
release is really, truly working.

Thanks,
Richard
