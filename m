From: wxt@rock-chips.com (Caesar Wang)
Date: Wed, 13 Jan 2016 10:08:49 +0800
Subject: [PATCH 0/1] Add the reboot mode dts for RK3036 SoCs
Message-ID: <1452650930-22883-1-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This patch is depend on the Andy' patches.
http://www.spinics.net/lists/kernel/msg2160362.html

This series patches are verified by the following URL:
https://github.com/Caesar-github/rockchip/commits/kylin-develop4.4

The base version is kernel 4.4 release version.



Caesar Wang (1):
  ARM: dts: rockchip: add reboot-mode node for rk3036 SoCs

 arch/arm/boot/dts/rk3036.dtsi | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

-- 
1.9.1
