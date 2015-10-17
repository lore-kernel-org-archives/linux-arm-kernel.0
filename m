From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sat, 17 Oct 2015 18:47:50 +0200
Subject: [GIT PULL 2/2] Rockchip dts32 changes for 4.4 part 2
In-Reply-To: <4398388.V5gVWEu8o6@diego>
References: <4398388.V5gVWEu8o6@diego>
Message-ID: <1646281.IJhPY0x0MY@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

since the first pull, Sjoerd's spdif driver got accepted into ASoC, so
this adds the spdif devicetree-nodes to the two supported Rockchip arches.

If it's not to late, please pull.

Thanks
Heiko


The following changes since commit b63af764ca5134341aa3a2836b356a65902ea9d4:

  ARM: dts: rockchip: add the support power-domain node on RK3288 SoCs (2015-10-08 22:41:11 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.4-rockchip-dts32-2

for you to fetch changes up to fea37552600872368a23019aef4bf8c09e0f0380:

  ARM: dts: rockchip: Add SPDIF optical out on Radxa Rock2 Square (2015-10-13 10:59:18 +0200)

----------------------------------------------------------------
SPDIF device nodes for the newly added driver.

----------------------------------------------------------------
Sjoerd Simons (4):
      ARM: dts: rockchip: Add SPDIF transceiver for RK3188
      ARM: dts: rockchip: Add SPDIF optical out on Radxa Rock
      ARM: dts: rockchip: Add SPDIF transceiver for RK3288
      ARM: dts: rockchip: Add SPDIF optical out on Radxa Rock2 Square

 arch/arm/boot/dts/rk3188-radxarock.dts    | 19 +++++++++++++++++++
 arch/arm/boot/dts/rk3188.dtsi             | 20 ++++++++++++++++++++
 arch/arm/boot/dts/rk3288-rock2-square.dts | 18 ++++++++++++++++++
 arch/arm/boot/dts/rk3288.dtsi             | 21 +++++++++++++++++++++
 4 files changed, 78 insertions(+)
