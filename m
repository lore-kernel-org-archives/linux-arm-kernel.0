From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 28 Nov 2011 13:28:44 +0100
Subject: [PATCH v10] AT91: Add a driver for the ADC
Message-ID: <1322483326-25570-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This is a new version of the ADC driver for AT91. I dropped the first patch
adding platform data from the patchset since Nicolas Ferre already included it
in his tree, and it didn't change from the v9 to the v10 anyway.

So, basically, in this version, the only thing that changed is that the driver
name is no longer at91adc but at91_adc. So there should be no functionnal
difference between the v9 and the v10, only s/at91adc/at91_adc/.

Regards,
Maxime
