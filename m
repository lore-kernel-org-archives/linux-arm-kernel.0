From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 5 Feb 2013 10:43:56 +0800
Subject: [GIT PULL] imx soc changes for 3.9
Message-ID: <20130205024354.GB10807@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

Here are the imx soc patches I queued for 3.9.  I have the branch based
on imx-cleanup-3.9 to resolve one conflict.  Please pull.  Thanks.

Shawn

The following changes since commit f662f52a91742f2aec738492eab87b937216d89f:

  Merge tag 'imx-cleanup-3.9' into imx/soc (2013-02-05 10:14:40 +0800)

are available in the git repository at:


  git://git.linaro.org/people/shawnguo/linux-2.6.git tags/imx-soc-3.9

for you to fetch changes up to 26246919329c045d8c1bd70dfebd44c54a5cf657:

  ARM: imx_v6_v7_defconfig: enable anatop regulator and snvs rtc (2013-02-05 10:14:55 +0800)

----------------------------------------------------------------
imx soc changes for 3.9

 - Sort out imx DEBUG_LL uart port selection
 - A couple of imx_v6_v7_defconfig updates

----------------------------------------------------------------
Fabio Estevam (1):
      ARM: imx_v6_v7_defconfig: Select IPUV3 driver

Shawn Guo (3):
      ARM: imx: use separated debug uart symbol for imx31 and imx35
      ARM: imx: support DEBUG_LL uart port selection for all i.MX SoCs
      ARM: imx_v6_v7_defconfig: enable anatop regulator and snvs rtc

 arch/arm/Kconfig.debug               |   31 ++++++++----
 arch/arm/configs/imx_v6_v7_defconfig |    7 +++
 arch/arm/include/debug/imx-uart.h    |   88 ++++++++++++++++++++++++++++++++++
 arch/arm/include/debug/imx.S         |   29 +----------
 4 files changed, 118 insertions(+), 37 deletions(-)
 create mode 100644 arch/arm/include/debug/imx-uart.h
