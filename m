From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 23 Nov 2015 13:12:52 +0100
Subject: [GIT PULL] ARM: rockchip: devicetree fixes for 4.4
Message-ID: <1896520.ssRYuZn5dZ@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:

  Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.4-rockchip-dts32-fixes1

for you to fetch changes up to 784359b824bf2b095b257eefcd9615a3c48f2d8a:

  ARM: dts: rockchip: Add OTP gpio pinctrl to rk3288 tsadc node (2015-11-19 05:50:42 +0100)

----------------------------------------------------------------
Two fixes to Rockchip devicetree files, disabling the mmc-tuning
on the veyron-minnie board for now and adding the init state for
the over-temperature-protection to prevent glitches making the
system reboot sometimes.

----------------------------------------------------------------
Caesar Wang (1):
      ARM: dts: rockchip: Add OTP gpio pinctrl to rk3288 tsadc node

Heiko Stuebner (1):
      ARM: dts: rockchip: temporarily remove emmc hs200 speed from rk3288 minnie

 arch/arm/boot/dts/rk3288-veyron-minnie.dts |  4 ++++
 arch/arm/boot/dts/rk3288.dtsi              | 10 ++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)
