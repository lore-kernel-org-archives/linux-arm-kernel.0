From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sat, 4 Aug 2012 15:57:19 +0200
Subject: [PATCH v6 0/3] Updated Cortex-M3 series
In-Reply-To: <20120803151740.GZ2005@localhost.localdomain>
References: <1343988614-5508-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <201208031407.09092.arnd@arndb.de>
 <20120803145035.GJ2626@pengutronix.de>
 <20120803151740.GZ2005@localhost.localdomain>
Message-ID: <20120804135719.GK2626@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, Aug 03, 2012 at 08:47:40PM +0530, Shiraz Hashim wrote:
> On Fri, Aug 03, 2012 at 10:50:35PM +0800, Uwe Kleine-K?nig wrote:
> > On Fri, Aug 03, 2012 at 02:07:08PM +0000, Arnd Bergmann wrote:
> > > Is it possible to build a NOMMU kernel that runs on both
> > > ARMv7-A amd ARMv7-M, in other words is ARMv7-M compatible with
> > > ARMv7-A (or ARMv7-R for that matter) if you don't use the MMU?
> >
> > the instructions to enable and disable irqs are different, so
> > we'd need another indirection at least there. Also the whole
> > exception model is different. So I'd say it's too different to
> > target for a common kernel for the A, R and M profiles.
> 
> We are using standard Linux kernel (v3.3) with MMU disabled on
> a Cortex R4 system.
Yeah, I expected A and R to be similar enough. It's the difference
between (A+R) and M that makes a common kernel for all three profiles
hard.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
