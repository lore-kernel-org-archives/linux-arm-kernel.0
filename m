From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 11 Jan 2010 22:04:08 +0800
Subject: [RFC PATCH 00/16] pxa gpio API cleanup
Message-ID: <1263218664-11546-1-git-send-email-eric.y.miao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These are mostly RFC, and there needs to be some cleanup still. Yet pasted
here firstly so any significant issues can be found. Anyway, this might be
the thing I'd like to get into .34, please help review.

Thanks.

[PATCH 01/16] [ARM] pxa/tosa: make use of the matrix keypad driver
[PATCH 02/16] [ARM] pxa: use chip->ack() instead of accessing GEDR directly
[PATCH 03/16] [ARM] pxa: simplify the LCD pin configuration for pxa25x platforms
[PATCH 04/16] [ARM] pxa: simplify the LCD pin configuration for pxa27x platforms
[PATCH 05/16] [ARM] pxa/cm-x270: avoid direct access of GPIO/MFP registers
[PATCH 06/16] [ARM] pxa: fix the incorrect naming of AC97 reset pin config for pxa26x
[PATCH 07/16] [ARM] pxa: remove the unnecessary restoring of MFP registers
[PATCH 08/16] [ARM] pxa: introduce processor specific pxa27x_assert_ac97reset()
[PATCH 09/16] [ARM] pxa: add the missing AC97 pin configurations
[PATCH 10/16] [ARM] pxa: remove now unnecessary pxa_gpio_mode() calls in ac97
[PATCH 11/16] gpio: introduce gpio_request_one() and friends
[PATCH 12/16] [ARM] pxa/corgi: use generic GPIO API and remove pxa_gpio_mode()
[PATCH 13/16] [ARM] pxa/spitz: use generic GPIO API and remove pxa_gpio_mode()
[PATCH 14/16] [ARM] pxa: fix irq suspend/resume for pxa25x
[PATCH 15/16] [ARM] pxa: add MFP_LPM_KEEP_OUTPUT flag to pin config
[PATCH 16/16] [ARM] pxa/corgi: cleanup GPIO configurations and low power mode settings
