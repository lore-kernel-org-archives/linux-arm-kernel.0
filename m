From: hdegoede@redhat.com (Hans de Goede)
Date: Mon,  8 Aug 2016 21:55:38 +0200
Subject: [PATCH resend 0/1] phy-sun4i-usb: Add support for peripheral-only mode
Message-ID: <1470686139-19893-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kishon,

As discussed before, here is a resend now that rc1 is out (and includes
the new of_usb_get_dr_mode_by_phy helper this patch needs).

Please merge this for 4.9-rcX some of the musb-sunxi glue changes
already merged have a runtime dependency on this patch, without
this patch boards using the musb controller in host-only mode
will break.

Thanks & Regards,

Hans
