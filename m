From: marcel.ziswiler@toradex.com (Marcel Ziswiler)
Date: Fri, 28 Aug 2015 14:42:27 +0200
Subject: [PATCH 0/9] arm: tegra: apalis_t30: fix pin mux, hdmi,
 wakeup and enable hda
Message-ID: <1440765756-1382-1-git-send-email-marcel.ziswiler@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series finally continues on my previous Easter efforts (BTW:
thanks all for the feedback and all the patches thereof already having
been applied) and additionally to fixing the pin muxing and enabling
HDA audio also fixes HDMI and the wake-up key.


Marcel Ziswiler (9):
  arm: tegra: apalis_t30: update hardware revisions compatibility
    comment
  arm: tegra: apalis_t30: fix hdmi supply
  arm: tegra: apalis_t30: fix pin muxing
  arm: tegra: apalis_t30: add comment concerning emmc
  arm: tegra: apalis_t30: add digital audio pin muxing
  arm: tegra: apalis_t30: enable hda for eval board
  arm: tegra: apalis_t30: set otg dr_mode for eval board
  arm: tegra: apalis_t30: fix backlight pwm comment for eval board
  arm: tegra: apalis_t30: fix power/wakeup key for eval board

 arch/arm/boot/dts/tegra30-apalis-eval.dts | 13 +++--
 arch/arm/boot/dts/tegra30-apalis.dtsi     | 80 ++++++++++++++++++++++++-------
 2 files changed, 73 insertions(+), 20 deletions(-)

-- 
2.4.3
