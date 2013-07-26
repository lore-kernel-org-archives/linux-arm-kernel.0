From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 26 Jul 2013 12:35:00 +0200
Subject: [PATCH 03/10] ARM: sunxi: Add the Allwinner A31 compatible to
 the machine definition
In-Reply-To: <1374618312-19001-4-git-send-email-maxime.ripard@free-electrons.com>
References: <1374618312-19001-1-git-send-email-maxime.ripard@free-electrons.com>
 <1374618312-19001-4-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20130726123500.58136be1@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Maxime Ripard,

On Wed, 24 Jul 2013 00:25:05 +0200, Maxime Ripard wrote:
> The Allwinner A31 is a quad-Cortex-A7 based SoC, which shares a lot of
> differences with the previous SoCs from Allwinner, like the PIO, I2C,

"shares a lot of differences" ? I suppose you meant "has a lot of
similarities", or "shares a number of hardware blocks", or something
like that?

> UARTs, timers, watchdog IPs, but also differs but droping the WEMAC

"but also differs but droping" ?

> ethernet controller and most notably droping the in-house IRQ
> controller in favor of a ARM GIC one.

droping -> dropping

</nitpick> :)

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
