From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 29 Mar 2015 12:50:45 +0200
Subject: [PATCH 0/3] Work around sunxi otg usb phy bug which causes lo-speed
 devices to not work
Message-ID: <1427626248-6257-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

Here is a patch-set to work around sunxi otg usb phy bug which causes
some lo-speed devices to not work (they get disconnected at there first reset).

This patch set uses a private sunxi phy function, I know that this is not
ideal, but given the rather perculiar nature of this bug / the needed
workaround I believe that a private sunxi phy function is the best solution
here.

This patch-set applies on top of my existing sun4i-usb-phy / musb-sunxi-glue
patches.

Regards,

Hans
