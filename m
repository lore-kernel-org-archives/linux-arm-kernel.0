From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Thu,  8 Aug 2013 14:51:19 +0200
Subject: [PATCH 0/10] ARM: mxs: update board support for TX28
Message-ID: <1375966287-6784-1-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- update the DTS file
- add defconfigs

 arch/arm/boot/dts/imx28.dtsi            |  110 ++++++--
 b/arch/arm/boot/dts/imx28-tx28.dts      |  693 +++++++++++++++++++++++++++++++++++++++++++++++-------
 b/arch/arm/boot/dts/imx28.dtsi          |    3 
 b/arch/arm/configs/tx28-debug_defconfig |  322 +++++++++++++++++++++++++
 b/arch/arm/configs/tx28_defconfig       |  307 +++++++++++++++++++++++
 5 files changed, 1327 insertions(+), 108 deletions(-)
