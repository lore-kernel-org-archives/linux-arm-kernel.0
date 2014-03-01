From: hdegoede@redhat.com (Hans de Goede)
Date: Sat,  1 Mar 2014 18:09:25 +0100
Subject: [PATCH v4 0/1] PHY: sunxi: Add driver for sunxi usb phy
Message-ID: <1393693766-15352-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kishon,

Here is v4 of my sunxi-usb-phy driver:

Changes in v2:
-Use macros rather then direct hex values for register addresses and bits
 where possible

Changes in v3:
-Fix check for wrong variable in error handling path pointed out by wens
-Switch to using reg-names to differentiate between the different register
 ranges needed

Changes in v4:
-Add one more macro for the PHY_CTRL register data bit
-Add some extra dependencies to the Kconfig entry
-Really fix the reset controller error handling path
-Add Maxime Ripard's Acked-by

Kishon, can you please queue up this patch for 3.15 ?

Regards,

Hans

p.s.

No dt patches this time as I'm going to send them as part of a larger sunxi dt
series later today.
