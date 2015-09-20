From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 20 Sep 2015 08:34:53 -0400
Subject: [PATCH resend] extcon: Fix attached value returned by
 is_extcon_changed
Message-ID: <1442752494-22244-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi MyungJoo,

Here is a resend of a bug-fix I send a while back, you said you would
merge this for v4.3-rc1, but I'm not seeing it there.

Can you please get this merged into 4.3, without this fix the sunxi
usb otg controller support which got merged in 4.3 will not work properly.

Regards,

Hans
