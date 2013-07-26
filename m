From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 26 Jul 2013 14:22:19 +0200
Subject: [PATCH 03/10] ARM: sunxi: Add the Allwinner A31 compatible to
 the machine definition
In-Reply-To: <20130726123500.58136be1@skate>
References: <1374618312-19001-1-git-send-email-maxime.ripard@free-electrons.com>
 <1374618312-19001-4-git-send-email-maxime.ripard@free-electrons.com>
 <20130726123500.58136be1@skate>
Message-ID: <20130726122219.GA3056@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Fri, Jul 26, 2013 at 12:35:00PM +0200, Thomas Petazzoni wrote:
> Dear Maxime Ripard,
> 
> On Wed, 24 Jul 2013 00:25:05 +0200, Maxime Ripard wrote:
> > The Allwinner A31 is a quad-Cortex-A7 based SoC, which shares a lot of
> > differences with the previous SoCs from Allwinner, like the PIO, I2C,
> 
> "shares a lot of differences" ? I suppose you meant "has a lot of
> similarities", or "shares a number of hardware blocks", or something
> like that?

Yep

> > UARTs, timers, watchdog IPs, but also differs but droping the WEMAC
> 
> "but also differs but droping" ?

*by* dropping.

> > ethernet controller and most notably droping the in-house IRQ
> > controller in favor of a ARM GIC one.
> 
> droping -> dropping
> 
> </nitpick> :)

Right.

Thanks!

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130726/0c4dcd13/attachment.sig>
