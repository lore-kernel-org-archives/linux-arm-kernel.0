From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sat, 3 Nov 2018 21:59:32 +0100
Subject: [PATCH v1 3/3] i2c: imx: don't print error if DMA is not
 configured
In-Reply-To: <20181029085408.GB4101@kunai>
References: <20181018112615.29362-1-o.rempel@pengutronix.de>
 <20181018112615.29362-4-o.rempel@pengutronix.de>
 <20181028221123.GE1882@kunai>
 <9a3fc087-2fe5-6d57-9b65-a05e176bf53d@pengutronix.de>
 <20181029085408.GB4101@kunai>
Message-ID: <20181103205932.hxqhwclb2jo6wo5n@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Wolfram, hello Oleksij,

On Mon, Oct 29, 2018 at 08:54:08AM +0000, Wolfram Sang wrote:
> On Mon, Oct 29, 2018 at 09:07:56AM +0100, Oleksij Rempel wrote:
> > On 28.10.18 23:11, Wolfram Sang wrote:
> > > On Thu, Oct 18, 2018 at 01:26:15PM +0200, Oleksij Rempel wrote:
> > > > At least on i.MX5x variants is DMA event for I2C muxed with SDHC. So
> > > > it is project specific configuration and not an error.
> > > > 
> > > > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > > 
> > > So, the first patch is not I2C realm, and the second is dropped. No
> > > comment about the third one?
> > > 
> > > And is maybe someone from Pengutronix interested in maintaining this
> > > driver? Uwe maybe? That would speed up things for it...
> > 
> > Should i resend it as single patch?
> 
> I am fine with an ack here.

With patch 1 dropped this patch needs adaption I think.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
