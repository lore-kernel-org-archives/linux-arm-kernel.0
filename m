From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 31 Jul 2016 17:23:06 +0200
Subject: [PATCH 0/4] input: touchscreen: Add generic touchscreen softbutton
 support
Message-ID: <1469978590-14081-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dmitry,

Some touchscreens extend over the display they cover and have a number
of capacative softbuttons outside of the display the cover.

With some hardware these softbuttons simply report touches with
coordinates outside of the normal coordinate space for touches on the
display.

This patch-series adds some generic helper code for supporting such
setups, including support for triggering a led as visual feedback that
a softbutton has been touched.

It also uses the generic helpers to add softbutton support to the
edt-ft5x06 driver.

Can you please review patches 1-3 and if they are to your liking merge
them ?

Note patch 4 is included mostly as illustration how this all can be used,
I will submit that to the sunxi dt maintainers once the input bits have
been merged.

Regards,

Hans
