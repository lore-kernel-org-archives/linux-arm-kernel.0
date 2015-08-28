From: marcel.ziswiler@toradex.com (Marcel Ziswiler)
Date: Fri, 28 Aug 2015 17:59:35 +0200
Subject: [PATCH 00/11] arm: tegra: colibri_t30: fix hdmi, power i2c,
 wakeup and activate touch
Message-ID: <1440777586-19545-1-git-send-email-marcel.ziswiler@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series finally continues on my previous Easter efforts (BTW:
thanks all for the feedback and all the patches thereof already having
been applied) and additionally to activating the STMPE811 touch
controller also fixes HDMI, power I2C and the wake-up key.


Marcel Ziswiler (11):
  arm: tegra: colibri_t30: update hardware revisions compatible comment
  arm: tegra: colibri_t30: fix hdmi supply
  arm: tegra: colibri_t30: improve comment about thermal alert pin
  arm: tegra: colibri_t30: add pin muxing for on-module power i2c
  arm: tegra: colibri_t30: fix comment about 3v3 fixed supply
  arm: tegra: colibri_t30: add touch pen interrupt pin muxing
  arm: tegra: colibri_t30: activate stmpe811 touch controller
  arm: tegra: colibri_t30: replace emmc label by comment
  arm: tegra: colibri_t30: fix vendor string of m41t0m6 rtc on eval
    board
  arm: tegra: colibri_t30: add comment concerning sd/mmc for eval board
  arm: tegra: colibri_t30: fix power/wakeup key for eval board

 arch/arm/boot/dts/tegra30-colibri-eval-v3.dts |   9 +-
 arch/arm/boot/dts/tegra30-colibri.dtsi        | 124 ++++++++++++++++++++++----
 2 files changed, 111 insertions(+), 22 deletions(-)

-- 
2.4.3
