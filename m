From: nm@ti.com (Nishanth Menon)
Date: Thu, 9 Apr 2015 17:33:15 -0500
Subject: [PATCH 0/2] ARM: dts: am57xx-beagle-x15: Updates for production X15
Message-ID: <1428618797-17190-1-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

BeagleBoard-X15 has had a few critical changes that impact
functionality. All previous BeagleBoard-X15s should now have been
updated or replaced with changes. If there are any further untracked
boards in the wild, TI will replace those platforms with updated ones
all-cost inclusive.

Obviously, we also need to add vbus-detect-gpio to enable complete
client functionality.

Further, these are not exactly 4.0-rc material anyways, but would be
nice to get into 4.1-rcs if possible - all our boards'd be broken in
upstream now till we merge these.

Bootlog after these fixes:
http://pastebin.ubuntu.com/10786281/

These patches are based off next-20150409

Nishanth Menon (2):
  ARM: dts: am57xx-beagle-x15: Switch UART mux pins
  ARM: dts: am57xx-beagle-x15: Switch GPIO fan number

 arch/arm/boot/dts/am57xx-beagle-x15.dts |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Regards,
Nishanth Menon
-- 
1.7.9.5
