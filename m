From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 03 Mar 2012 22:34:26 +0100
Subject: Status of gpio-pxa driver and dummy clock
Message-ID: <87eht9tllp.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Haojian,

As you certainly know, Russell reverted the patch "ARM: pxa: add dummy clock for
sa1100-rtc", id a55b5adaf403c4d032e0871ad4ee3367782f4db6. As a consequence, the
dummy clock for gpio-pxa was removed, causing breakage of gpio-pxa driver.

I wonder if you (or somebody through you) sent an update to fix the gpio-pxa by
either fixing gpio-pxa or adding back "pxa-gpio" clock. As of today, I see no
fix in 3.3-rc free (Linus tree).

Cheers.

-- 
Robert
