From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 31 Jul 2015 10:59:49 +0200
Subject: [PATCH 0/5] ARM: dts: sunxi: Enable USB DRC on a bunch of boards
Message-ID: <1438333194-21181-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

Here is a set of patches to enable the otg on 4 more boards, and adding
a dts file for the Wits a20 Pro Development kit. Most of these are the
result of the devicetree workshop I organized last weekend :) All of them
have been doublechecked for correctness and were tested on the actual
hardware.

This set does not include some pending dts patches for enabling otg on
boards which use the axp209 to do vbus-detection on the otg port, as
the necessary mfd / power-supply bits are not merged yet. I'll try to
get those queued up for 4.3, and when they are I'll send you another
set of otg enablement patches for these boards.

Regards,

Hans
