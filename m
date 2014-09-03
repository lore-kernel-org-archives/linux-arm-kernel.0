From: t-kristo@ti.com (Tero Kristo)
Date: Wed, 3 Sep 2014 11:18:11 +0300
Subject: [GIT PULL] ARM: OMAP3: quick clock dts fix for 3.17-rc
Message-ID: <5406CEC3.5000601@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:

   Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)

are available in the git repository at:

   git at github.com:t-kristo/linux-pm.git for-v3.17-rc/ti-clk-dt

for you to fetch changes up to adf5b4dcc0cf50715f74f49f3c7af0c80467f55f:

   ARM: dts: set 'ti,set-rate-parent' for dpll4_m5x2 clock (2014-08-21 
18:01:35 +0300)

----------------------------------------------------------------
Stefan Herbrechtsmeier (1):
       ARM: dts: set 'ti,set-rate-parent' for dpll4_m5x2 clock

  arch/arm/boot/dts/omap3xxx-clocks.dtsi |    1 +
  1 file changed, 1 insertion(+)
