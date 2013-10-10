From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 10 Oct 2013 16:16:25 +0900
Subject: [PATCH 00/11] Marzen and Bockw defconfig updates
Message-ID: <1381389396-22000-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this series of defconfig updates aims to bring the bockw
and marzen defconfigs more into line with the other shmobile
defconfigs. It also allows the marzen and bockw boards
to boot into a Debian armhf userspace, again in
line with the defconfigs for other shmobile boards.

Simon Horman (11):
  ARM: shmobile: bockw: Do not set command line in defconfig
  ARM: shmobile: marzen: Do not set command line in defconfig
  ARM: shmobile: bockw: Do not disable CONFIG_INOTIFY_USER in defconfig
  ARM: shmobile: marzen: Do not disable CONFIG_INOTIFY_USER in defconfig
  ARM: shmobile: bockw: Enable CONFIG_VFP in defconfig
  ARM: shmobile: marzen: Enable CONFIG_VFP in defconfig
  ARM: shmobile: bockw: Do not enable CONFIG_DEVTMPFS defconfig
  ARM: shmobile: marzen: Do not enable CONFIG_DEVTMPFS defconfig
  ARM: shmobile: bockw: Enable CONFIG_PACKET in defconfig
  ARM: shmobile: marzen: Enable CONFIG_PACKET in defconfig
  ARM: shmobile: marzen: Do not enable CONFIG_SMC911X in defconfig

 arch/arm/configs/bockw_defconfig  | 7 ++-----
 arch/arm/configs/marzen_defconfig | 8 ++------
 2 files changed, 4 insertions(+), 11 deletions(-)

-- 
1.8.4
