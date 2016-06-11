From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 11 Jun 2016 15:53:00 +0200
Subject: [PATCH 0/6] ARM: dts: sunxi: Enable otg support on a23/a33 boards
Message-ID: <1465653186-953-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

All the necessary bits for this have been merged in the various foo-next
tree-s, so lets merge the dts bits and enable full otg support on these
boards.

Note that we cannot yet do this for a31 based boards as the axp221 pmic
has a quirk where it will not generate interrupts for vbus state changes
when it itself is driving vbus. I've a patch to work around this, but
this patch is part of a larger set which still needs to be merged.

Regards,

Hans
