From: viresh.kumar@st.com (Viresh Kumar)
Date: Wed, 9 May 2012 16:44:33 +0530
Subject: [GIT PULL] SPEAr SMI updates for v-3.5
Message-ID: <1336562073-24446-1-git-send-email-viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,Olof,

The following changes since commit 0e74bbef7c071aafb90ab10728197b1f325d1b5c:

  SPEAr: Update MAINTAINERS and Documentation (2012-05-09 14:46:46 +0530)

are available in the git repository at:

  git://git.stlinux.com/spear/linux-2.6.git for-v3.5-spear-smi-update

for you to fetch changes up to 880702fb50ec63a832aaeafcb251295f3c6ce722:

  SPEAr: Update defconfigs (2012-05-09 14:53:53 +0530)

----------------------------------------------------------------
Viresh Kumar (2):
      SPEAr: Add SMI NOR partition info in dts files
      SPEAr: Update defconfigs

 arch/arm/boot/dts/spear1310-evb.dts  |   25 +++++++++++++++++++++++++
 arch/arm/boot/dts/spear1340-evb.dts  |   25 +++++++++++++++++++++++++
 arch/arm/boot/dts/spear300-evb.dts   |   25 +++++++++++++++++++++++++
 arch/arm/boot/dts/spear310-evb.dts   |   20 ++++++++++++++++++--
 arch/arm/boot/dts/spear320-evb.dts   |   25 +++++++++++++++++++++++++
 arch/arm/boot/dts/spear600-evb.dts   |   29 +++++++++++++++++++++++++++++
 arch/arm/configs/spear13xx_defconfig |    4 ++++
 arch/arm/configs/spear3xx_defconfig  |    4 ++++
 arch/arm/configs/spear6xx_defconfig  |    5 ++++-
 9 files changed, 159 insertions(+), 3 deletions(-)
