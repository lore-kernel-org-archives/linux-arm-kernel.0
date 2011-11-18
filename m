From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 18 Nov 2011 11:12:37 +0100
Subject: [PATCH v8] AT91: Add a driver for the ADC
Message-ID: <1321611160-3685-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This patchset adds the driver for the ADC in the AT91 SoC. It has been tested on
the at91sam9g20ek and should work on sam9g45 as well.

For now, it only reads values when asked for by sysfs, but eventually will
support hardware triggers and more boards.

This patchset is based on the "[PATCH 0/6 V2] IIO: Out of staging step 1: The
core" patchset from Jonathan Cameron, applied on top of 3.1

Improvements from v7:
  - Fix the channels mask bug

Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
