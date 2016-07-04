From: hdegoede@redhat.com (Hans de Goede)
Date: Mon,  4 Jul 2016 23:17:32 +0200
Subject: [PATCH v6 0/1] phy-sun4i-usb: Add support for peripheral-only mode
Message-ID: <1467667053-15122-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kishon,

Thanks for merging one of the 2 pending phy-sun4i-usb patches, I see
that the other one actually has a conflict after merging in
linux-phy/fixes. So here is a rebased version of it.

Note can you please make sure this gets into 4.8? I've a musb patch
("usb: musb: sunxi: Simplify dr_mode handling") heading into 4.8,
which depends on the changes in this patch to keep host-only mode
working (runtime dependency) and we do use host-only mode on a few
boards.

Thanks & Regards,

Hans
