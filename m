From: tony@atomide.com (Tony Lindgren)
Date: Fri, 12 Feb 2016 14:21:45 -0800
Subject: [PATCH 0/3] arm: dts: DRA7: Add IVA and DSPEVE thermal domain data
In-Reply-To: <20160209215210.GB27284@localhost.localdomain>
References: <1454922990-7501-1-git-send-email-j-keerthy@ti.com>
 <20160209215210.GB27284@localhost.localdomain>
Message-ID: <20160212222144.GN19432@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Eduardo Valentin <edubezval@gmail.com> [160209 13:53]:
> On Mon, Feb 08, 2016 at 02:46:27PM +0530, Keerthy wrote:
> > OMAP5 has 3 thermal zones cpu, core and multimedia.
> > On the other hand DRA7 has 5 thermal zones cpu, gpu, core, dspeve
> > and iva. Currently cpu, core and multimedia are being added via dt
> > and the other 2 are getting added via kernel. Add the missing thermal
> > domains in dt so as give the correct trip numbers, type and temperatures.
> > 
> > Tested on DRA7-EVM.
> 
> For the series:
> 
> Acked-by: Eduardo Valentin <edubezval@gmail.com>

Applying all into omap-for-v4.6/dt thanks.

Tony
