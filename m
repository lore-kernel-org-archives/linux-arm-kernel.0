From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 8 Jan 2013 23:26:47 +0800
Subject: [GIT PULL] imx fixes for 3.8
Message-ID: <20130108152646.GG19534@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit a49f0d1ea3ec94fc7cf33a7c36a16343b74bd565:

  Linux 3.8-rc1 (2012-12-21 17:19:00 -0800)

are available in the git repository at:

  git://git.linaro.org/people/shawnguo/linux-2.6.git tags/imx-fixes-3.8

for you to fetch changes up to e37f0d5b32c2a66677d0f2a21431a87e7e9ce22d:

  ARM: mx5: Fix MX53 flexcan2 clock (2013-01-08 08:53:07 +0800)

----------------------------------------------------------------
It includes one critical fix - wrong flexcan2 clock will hang system
when the port gets brought up.  The other two are non-critical fixes,
which are sent together here, since it's still early -rc stage.

----------------------------------------------------------------
Fabio Estevam (2):
      clk: imx: Remove 'clock-output-names' from the examples
      ARM: dts: imx31-bug: Fix manufacturer compatible string

Marek Vasut (1):
      ARM: mx5: Fix MX53 flexcan2 clock

 .../devicetree/bindings/clock/imx23-clock.txt      |    5 -----
 .../devicetree/bindings/clock/imx25-clock.txt      |    4 ----
 .../devicetree/bindings/clock/imx28-clock.txt      |    5 -----
 .../devicetree/bindings/clock/imx6q-clock.txt      |    4 ----
 arch/arm/boot/dts/imx31-bug.dts                    |    2 +-
 arch/arm/boot/dts/imx53.dtsi                       |    2 +-
 6 files changed, 2 insertions(+), 20 deletions(-)
