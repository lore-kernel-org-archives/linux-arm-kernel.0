From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 19 Oct 2011 18:18:51 +0200
Subject: [PATCH] AT91: Add a driver for the ADC
Message-ID: <1319041134-19712-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This patchset adds the driver for the ADC in the AT91 SoC. It has been tested on
the at91sam9g20ek and should work on sam9g45 as well.

For now, it only reads values when asked for by sysfs, but eventually will
support hardware triggers and more boards.

This patchset is based on the branch master of Jonathan Cameron present at :
https://github.com/jic23/linux-iio/

Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
