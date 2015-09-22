From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 23 Sep 2015 01:01:31 +0200
Subject: [GIT PULL] Rockchip dts32 fix for 4.3
Message-ID: <3645157.N6ZMkqFz42@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

one small dts fix turned up for veyron devices to let the read hdmi edids
which I hope can still be part of 4.3.

Thanks
Heiko


The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.3-rockchip32-dtsfixes1

for you to fetch changes up to a797451b3a595759b4df48150e611237d4bd204a:

  ARM: dts: Add ddc i2c reference to veyron (2015-09-13 14:21:39 +0200)

----------------------------------------------------------------
Add the ddc-i2c-bus reference to the veyron hdmi nodes,
so that they can read the edid of connected displays.

----------------------------------------------------------------
Douglas Anderson (1):
      ARM: dts: Add ddc i2c reference to veyron

 arch/arm/boot/dts/rk3288-veyron.dtsi | 1 +
 1 file changed, 1 insertion(+)
