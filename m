From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Wed, 29 Mar 2017 16:32:23 +0300
Subject: [RFC 8/8] ARM: dts: imx6qdl-sabresd: Enable fsl,ldo-bypass
In-Reply-To: <1490202830.29056.8.camel@pengutronix.de>
References: <cover.1490199005.git.leonard.crestez@nxp.com>
 <8f4dca5609781f0362009dfa7f6d5c0990b5ea6d.1490199005.git.leonard.crestez@nxp.com>
 <1490202830.29056.8.camel@pengutronix.de>
Message-ID: <1490794343.5481.33.camel@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2017-03-22 at 18:13 +0100, Lucas Stach wrote:
> Am Mittwoch, den 22.03.2017, 18:53 +0200 schrieb Leonard Crestez:

> > This enables LDO bypass by default on the imx6qdl-sabresd boards. New
> > dts files with -ldo suffix are added for users who want to run with LDOs
> > enabled on these boards anyway.

> Given that using LDO bypass affects the device lifetime negatively (see
> AN4724), I think the default should still be to use LDO enabled mode and
> have new DTs for people that desire to shorten the lifetime of the SoC
> for a minimal drop in power consumption.

This was based on what the Freescale BSP does, I don't particularly
object to upstream having a different default. It would be nice for
testing if this ldo-bypass path was enabled by default for some boards
but it's not a very good reason.

I will switch the default.

--?
Regards,
Leonard
