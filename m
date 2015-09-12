From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 12 Sep 2015 14:58:32 +0200
Subject: [PATCH v2 0/1] devicetree: bindings: Update gpio-keys-polled with
 support
Message-ID: <1442062713-21260-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

Here is v2 of the patch adding support for EV_ABS/EV_REL to the'
gpio-keys-polled devicetree bindings. This version addresses Rob's
comments.

Dmitry, I believe it makes the most sense if you merge this together with
the patch actually implementing support for this in the gpio_keys_polled.c
driver. Let me know if you've any remarks on that driver and I need to respin
it.

I will prepare a new patch-set to deal with making the evdev defines
available for use in dts files. The plan is to split out a file with just the
defines out of the existing linux/input.h, and make include/dt-bindings/input.h
a symlink to this split-out file.

Regards,

Hans
