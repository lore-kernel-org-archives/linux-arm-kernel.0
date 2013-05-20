From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 21 May 2013 02:11:15 +0900
Subject: [GIT PULL] Samsung fixes-2 for v3.10
Message-ID: <519A5933.3040005@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit f722406faae2d073cc1d01063d1123c35425939e:

   Linux 3.10-rc1 (2013-05-11 17:14:08 -0700)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
tags/samsung-fixes-2

for you to fetch changes up to 7ec892ef5f1bd707e2d5ab128069cb6af75c7f07:

   ARM: dts: Enabling samsung-usb2phy driver for exynos5250 (2013-05-21 
01:26:17 +0900)

----------------------------------------------------------------
Fix to get usb2 working on the Chromebook with adding the
usb phy node for usb2 on exynos5250

----------------------------------------------------------------
Vivek Gautam (1):
       ARM: dts: Enabling samsung-usb2phy driver for exynos5250

  arch/arm/boot/dts/exynos5250.dtsi | 15 +++++++++++++++
  1 file changed, 15 insertions(+)
