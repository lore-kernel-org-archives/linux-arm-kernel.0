From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 17 Dec 2013 17:16:34 +0100
Subject: [PATCH 2/2] ARM: device trees for Energy Micro's EFM32 Cortex-M3
 SoCs
In-Reply-To: <20131217153136.GA5564@netboy>
References: <20131216190953.GB14866@pengutronix.de>
 <1387221123-6794-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20131217113750.GB5307@netboy>
 <20131217131730.GI14866@pengutronix.de>
 <20131217153136.GA5564@netboy>
Message-ID: <20131217161634.GK14866@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Richard,

On Tue, Dec 17, 2013 at 04:31:38PM +0100, Richard Cochran wrote:
> On Tue, Dec 17, 2013 at 02:17:30PM +0100, Uwe Kleine-K?nig wrote:
> > On Tue, Dec 17, 2013 at 12:37:51PM +0100, Richard Cochran wrote:
> > > On Mon, Dec 16, 2013 at 08:12:03PM +0100, Uwe Kleine-K?nig wrote:
> > > 
> > > > +		cmu: cmu at 400c8000 {
> > > > +			compatible = "efm32gg,cmu";
> > > 
> > > I was able to run this on the EFM32LG without problems.  Are you sure
> > > this CMU node is specific to the GG, or can it be shared?
> > I remember me being grumpy because I found some differences between the
> > GG and some other efm32 device. After looking again I cannot find the
> > problem. Maybe the LG is compatible but some other is not.
> 
> It looked like to me that the only differences are flash and ram
> sizes, and presence or absence of peripherals, but I don't know all of
> the many EM parts that well, just these two.
I asked my contact at Silabs, and he told that LG, GG and WG are
similar. Looking at the reference manual of the Gecko Series you can see
that for example the bits in CMU_HFPERCLKEN0 are different.
A tool to judge about differences of the different SoCs would be nice.
 
> > Can I assume your feedback as Tested-by:?
> 
> Yes, by all means, please do.
Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
