From: s.hauer@pengutronix.de (Sascha linux-arm)
Date: Fri, 11 Dec 2009 13:44:52 +0100
Subject: [PATCH 4/4] MXC: imx31pdk: Trying to enabling regulators on
	mc13783
In-Reply-To: <20091210191017.GB22554@sirena.org.uk>
References: <1260470224.2141.37.camel@climbing-alby>
	<1260470547.2141.42.camel@climbing-alby>
	<1260470743.2141.45.camel@climbing-alby>
	<1260471013.2141.49.camel@climbing-alby>
	<1260471404.2141.56.camel@climbing-alby>
	<20091210191017.GB22554@sirena.org.uk>
Message-ID: <20091211124452.GO15126@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 10, 2009 at 07:10:17PM +0000, Mark Brown wrote:
> On Thu, Dec 10, 2009 at 07:56:44PM +0100, Alberto Panizzo wrote:
> 
> > +/* MC13783 */
> > +#define mV_to_uV(mV) (mV * 1000)
> 
> Define this somewhere global, it's generally useful.

And please define it like

#define mV_to_uV(mV) ((mV) * 1000)

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
