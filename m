From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 24 Nov 2011 12:27:17 +0100
Subject: [PATCH v9] AT91: Add a driver for the ADC
Message-ID: <1322134040-32382-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

The last version had a bug in the error handling of the probe function
of the adc driver, the free_irq call having the wrong dev_id. This
version corrects it.

Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
