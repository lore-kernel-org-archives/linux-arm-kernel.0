From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 16 Jan 2012 22:36:23 +0100
Subject: [PATCH RESEND v13] AT91: Add a driver for the ADC
Message-ID: <1326749786-13035-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Working on supporting the hardware triggers for these drivers, I made some
patches that Jonathan suggested I merge with this patchset.

So, basically, what changed from v12:
  * Indentation fixes, added some comments
  * Rework of the platform data. Now the SoC-specific data are directly in the
driver, as it was kind of odd to declare all the triggers for the driver in the
SoC files. So the driver handles all of this now. It has nice side effects, as
it will also ease the transition to DT.

As it introduce heavy changes, I dropped the Acked-by and Signed-off-by from
the two last patches.

Maxime

Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
