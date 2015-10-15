From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 15 Oct 2015 16:27:24 +0200
Subject: [PATCH 0/2] pinctrl: sunxi: r_pio pinctrl irq fixes
Message-ID: <1444919246-23694-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus, Maxime,

Here are some fixes for supporting external interrupts connected to
the "r" (extra) pincontroller found on newer sunxi SoCs.

This series has been tested on a BPI-M2 which has the sdio OOB irq
hooked up to PL5, with this series applied the OOB irq works as it
should.

Regards,

Hans
