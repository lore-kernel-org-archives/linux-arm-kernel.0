From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed,  9 May 2012 11:05:57 +0200
Subject: [PATCHv3] Add ADC driver for Atmel G20, G45 and X5 boards
Message-ID: <1336554366-16957-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Here is another version of the patches to bring ADC driver to Atmel boards.
Since last version, here is what changed:
  * Rebased on top of staging-next to move out of staging. Had to change to IIO
    kfifo buffer along the way.
  * Reworked the DT bindings according to Jean-Christophe reviews
  * Made various fixes according to reviews
  * Support for X5 boards

Thanks,
Maxime
