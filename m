From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Mon, 28 Feb 2011 16:25:45 +0100
Subject: [patch 1/2] mc13892: reboot on wdi event
In-Reply-To: <20110228143552.GC13869@opensource.wolfsonmicro.com> (Mark
	Brown's message of "Mon, 28 Feb 2011 14:35:52 +0000")
References: <20110228132132.654689676@rtp-net.org>
	<20110228132643.964403175@rtp-net.org>
	<20110228143552.GC13869@opensource.wolfsonmicro.com>
Message-ID: <87k4gkyydi.fsf@lebrac.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown <broonie@opensource.wolfsonmicro.com> writes:

> On Mon, Feb 28, 2011 at 02:21:33PM +0100, Arnaud Patard wrote:
>> By default, on wdi (watchdog input) event the mc13892 is powering off.
>> This patch is changing this to reboot on wdi event.
>> 
>> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
>
> This strikes me as something that should be configurable by platforms.

afaik, mc13892 is used only on imx designs and the reset for imx is done
only throught the watchdog. From this point of view,  I don't see any
valid reason for powering off instead of rebooting on watchdog event


Arnaud
