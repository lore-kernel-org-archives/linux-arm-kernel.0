From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 7 Dec 2009 18:30:56 +0000
Subject: MXC: MC13783 Voltage regulation full support
In-Reply-To: <20091207182229.GA25509@pengutronix.de>
References: <1260199017.2166.14.camel@climbing-alby>
	<20091207182229.GA25509@pengutronix.de>
Message-ID: <20091207183056.GB9018@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 07, 2009 at 07:22:29PM +0100, Uwe Kleine-K?nig wrote:
> On Mon, Dec 07, 2009 at 04:16:57PM +0100, Alberto Panizzo wrote:

> > Or are there some problems pending that explain why the present driver
> > can only enable or disable regulators? 

> I think the only problem was that Sascha havn't had the need for full
> regulators and so didn't invest the time.  Note that the driver changed
> in next if you plan to send patches.

The hardware can certainly work with the API, the Freescale drivers have
done so for a while.
