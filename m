From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 31 May 2015 18:10:24 +0200
Subject: [PATCH v4 0/2] Remaining sunxi musb patches
Message-ID: <1433088626-8858-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kishon & Felipe,

Here is an updated version of the remaining (not yet merged in Felipe's tree)
sunxi musb patches.

The "phy-sun4i-usb: Add full support for usb0 phy / OTG" patch has been
updated with a small bug-fix and is ready for merging.

The "musb: Add support for the Allwinner sunxi musb" patch has been updated
to use the latest version of Maxime's sunxi sram controller driver. This
one has a compile-time dependency on Maxime's sunxi sram controller driver,
so it cannot be merged until that is merged.

I also have updated the dts patches enabling the sunxi musb controller on a
number of boards for the sram controller changes, you can look at these
here: https://github.com/jwrdegoede/linux-sunxi/commits/sunxi-wip

I'll post a new version of the dts patches for upstreaming as soon as the
other bits are merged.

Regards,

Hans
