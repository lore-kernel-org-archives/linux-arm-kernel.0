From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu,  5 Apr 2012 18:01:19 +0200
Subject: [PATCH] Add ADC driver for G20 and G45 evaluation boards
Message-ID: <1333641684-20325-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Here is the improved version of what I've been posting some time ago.
Some things changed since last version:
  - Support for Hardware triggers for the G20 has been added
  - Support for the AT91SAM9M10G45 board has been added too, both for
    software and hardware triggers
  - The driver is now in drivers/staging/iio to include all these features.

The first three patches should not have changed much since last post, so it
should be pretty ok.

Thanks,
Maxime
