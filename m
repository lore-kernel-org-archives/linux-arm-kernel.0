From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 20 Sep 2015 08:30:46 -0400
Subject: [PATCH 0/5] ARM: dts: sunxi: Add backlight node to q8 tablets
Message-ID: <1442752251-20744-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime, Chen-Yu,

Here is a slightly updated version of Chen-Yu's backlight
patches, also adding support for the backlight found on A13 
based q8 tablets.

This series is based on mripard/sunxi/for-next with the following
patches on top (Maxime you've send mails indicating that you've merged
these alread, but you seem to have not pushed them yet) :

ARM: dts: sun5i: Add sun5i-q8-common.dtsi
ARM: dts: sun5i: Add dts file for q8 formfactor a13 based tablets
ARM: dts: sun8i: Add PWM controller node for A23/A33
ARM: dts: sun8i: Add PWM channel 0 pinmux setting for A23/A33

As discussed I've changed the "ARM: dts: sunxi: Enable PWM controller
on Q8 format tablets" patch to enable the pwm node in sunxi-q8-common.h
rather then in sunx8i-q8-common.h, other then that the 2 patches from
Chen-Yu are unchanged.

Regards,

Hans
