From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed,  9 May 2012 15:01:59 +0200
Subject: [PATCHv4] Add ADC driver for Atmel G20, G45 and X5 boards
Message-ID: <1336568528-29877-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Here is another round of ADC patches based on reviews from Nicolas Ferre.
Nothing really fancy here, mostly changed the compatible string to at91sam9260
since the g20 and the 9260 both share the same ADC, and various small fixes,
typos, etc.

Thanks,
Maxime
