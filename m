From: marc@cpdesign.com.au (Marc Reilly)
Date: Fri, 13 Jul 2012 09:02:56 +1000
Subject: [PATCH 0/7] Add support for Freescale's mc34708 to mc13xxx driver
In-Reply-To: <1342087073-3892-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1342087073-3892-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <11987916.rOoNGcb1ly@dev1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

> This series was tested on a Phytec pcm038 (mc13783 on spi) using
> traditional boot (i.e. not dt) and on a i.MX53 based machine (mc34708 on
> i2c) using dt boot.
> 
> Philippe's patches are already in next, they are just included here for
> those who want to test the patches. The 'mfd/mc13xxx: drop modifying
> driver's id_table in probe' was already sent out yesterday and is
> included here because the last patch depends on it.
> 

For all patches (that don't already have it):
Acked-by: Marc Reilly <marc@cpdesign.com.au>

If for some reason you do a V2:
- In patch 6 moves line "#define MC13XXX_NUMREGS 0x3f" around, is this 
necessary?
- Patch 4 should come last, ie after "add support for mc34708"

Cheers,
Marc
