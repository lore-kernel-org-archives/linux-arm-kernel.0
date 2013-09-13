From: tony@atomide.com (Tony Lindgren)
Date: Fri, 13 Sep 2013 12:09:48 -0700
Subject: [PATCH 0/2] WLAN regression fixes for omap4 after moving to DT
 based booting
Message-ID: <20130913190811.24617.97699.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Looks like these two patches are still missing as I did not
update the kernel on my panda for a while but was testing with
my 4430sdp that does not have the WLAN card..

Regards,

Tony

---

Tony Lindgren (2):
      ARM: dts: Fix muxing and regulator for wl12xx on the SDIO bus for pandaboard
      ARM: dts: Fix muxing and regulator for wl12xx on the SDIO bus for blaze


 arch/arm/boot/dts/omap4-panda-common.dtsi |   46 ++++++++++++++++++++++++++++-
 arch/arm/boot/dts/omap4-sdp.dts           |   39 ++++++++++++++++++++++++-
 2 files changed, 83 insertions(+), 2 deletions(-)

-- 
Signature
