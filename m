From: lrg@slimlogic.co.uk (Liam Girdwood)
Date: Thu, 10 Dec 2009 19:39:25 +0000
Subject: [PATCH 4/4] MXC: imx31pdk: Trying to enabling regulators on
	mc13783
In-Reply-To: <1260473248.2141.75.camel@climbing-alby>
References: <1260470224.2141.37.camel@climbing-alby>
	<1260470547.2141.42.camel@climbing-alby>
	<1260470743.2141.45.camel@climbing-alby>
	<1260471013.2141.49.camel@climbing-alby>
	<1260471404.2141.56.camel@climbing-alby>
	<20091210191017.GB22554@sirena.org.uk>
	<1260473248.2141.75.camel@climbing-alby>
Message-ID: <1260473965.3625.218.camel@odin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2009-12-10 at 20:27 +0100, Alberto Panizzo wrote:
> Il giorno gio, 10/12/2009 alle 19.10 +0000, Mark Brown ha scritto:
> > On Thu, Dec 10, 2009 at 07:56:44PM +0100, Alberto Panizzo wrote:
> > 
> > > +/* MC13783 */
> > > +#define mV_to_uV(mV) (mV * 1000)
> > 
> > Define this somewhere global, it's generally useful.
> 
> Yes, maybe in include/linux/mfd/mc13783.h 
> 

This is actually quite useful to other drivers too as most seem to work
in mV. What about in regulator/driver.h 

Thanks

Liam
