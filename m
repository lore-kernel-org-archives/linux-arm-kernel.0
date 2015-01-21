From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 21 Jan 2015 22:50:41 +0100
Subject: [GIT PULL 2/2] ARM: rockchip: soc updates for 3.20
In-Reply-To: <2314612.MtoMVTtzSS@phil>
References: <2314612.MtoMVTtzSS@phil>
Message-ID: <1832574.qpHkTgdMBa@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:

  Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v3.20-rockchip-dts1

for you to fetch changes up to 5963e106df7b601a8f23cbbaac1420e4c740ada6:

  ARM: dts: rockchip: add suspend settings for rk3288-evb-rk808 (2014-12-31 16:19:18 +0100)

----------------------------------------------------------------
dts part of core suspend support and limiting of rk3288
sd-card clockspeed to 150mhz

----------------------------------------------------------------
Addy Ke (1):
      ARM: dts: rockchip: set dw_mmc max-freq 150Mhz

Chris Zhong (2):
      ARM: dts: rockchip: add RK3288 suspend support
      ARM: dts: rockchip: add suspend settings for rk3288-evb-rk808

 arch/arm/boot/dts/rk3288-evb-rk808.dts | 53 +++++++++++++++++++++++++++++++++-
 arch/arm/boot/dts/rk3288.dtsi          | 27 +++++++++++++++++
 2 files changed, 79 insertions(+), 1 deletion(-)
