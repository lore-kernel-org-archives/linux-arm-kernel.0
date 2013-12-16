From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 16 Dec 2013 09:34:07 +0900
Subject: [PATCH 0/2] ARM: shmobile: koelsch: defconfig updates
Message-ID: <1387154049-9105-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Updates for Koelsch defconfig to allow it to boot
a Debian armhf userspace and to bring it into line
with other shmobile defconfigs.

Based on the renesas-devel-v3.13-rc3-20131214v2 tag
of my renesas tree.

Simon Horman (2):
  ARM: shmobile: koelsch: Enable CONFIG_PACKET in defconfig
  ARM: shmobile: koelsch: Do not disable CONFIG_{INOTIFY_USER,UNIX} in
    defconfig

 arch/arm/configs/koelsch_defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
1.8.4
