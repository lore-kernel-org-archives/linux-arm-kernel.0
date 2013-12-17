From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 17 Dec 2013 14:17:30 +0100
Subject: [PATCH 2/2] ARM: device trees for Energy Micro's EFM32 Cortex-M3
 SoCs
In-Reply-To: <20131217113750.GB5307@netboy>
References: <20131216190953.GB14866@pengutronix.de>
 <1387221123-6794-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20131217113750.GB5307@netboy>
Message-ID: <20131217131730.GI14866@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 17, 2013 at 12:37:51PM +0100, Richard Cochran wrote:
> On Mon, Dec 16, 2013 at 08:12:03PM +0100, Uwe Kleine-K?nig wrote:
> 
> > +		cmu: cmu at 400c8000 {
> > +			compatible = "efm32gg,cmu";
> 
> I was able to run this on the EFM32LG without problems.  Are you sure
> this CMU node is specific to the GG, or can it be shared?
I remember me being grumpy because I found some differences between the
GG and some other efm32 device. After looking again I cannot find the
problem. Maybe the LG is compatible but some other is not.

Can I assume your feedback as Tested-by:?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
