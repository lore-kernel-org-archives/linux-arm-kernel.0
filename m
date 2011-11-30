From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 30 Nov 2011 10:14:59 +0100
Subject: [PATCH v11] AT91: Add a driver for the ADC
Message-ID: <1322644502-18160-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

As suggested by Arnd, I moved the platform data from the board.h additions in
the first patch to a new include/linux/platform_data/at91_adc.h file for this
version.

Maxime

Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
