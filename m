From: yoshihiro.shimoda.uh@renesas.com (Yoshihiro Shimoda)
Date: Thu, 29 May 2014 19:59:48 +0900
Subject: [PATCH 0/2] arm: shmobile: add USB 3.0 DT for r8a7790
Message-ID: <53871324.1080908@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series is based on the renesas-devel-v3.15-rc7-20140528
in renesas.git.

Also this patch needs the following patch:
http://marc.info/?l=linux-sh&m=140088408626977&w=2

Yoshihiro Shimoda (2):
  arm: shmobile: r8a7790: add USB3.0 clocks to device tree
  arm: shmobile: r8a7790: add USB3.0 node to r8a7790.dtsi

 arch/arm/boot/dts/r8a7790.dtsi |   16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

-- 
1.7.9.5
