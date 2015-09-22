From: nm@ti.com (Nishanth Menon)
Date: Tue, 22 Sep 2015 10:42:24 -0500
Subject: [PATCH 0/2] ARM: configs: keystone: update to support newer distros
Message-ID: <1442936546-8295-1-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Basic support for systemd based distros to be supported by default on
keystone_defconfig.

Series based on v4.3-rc1

Nishanth Menon (2):
  ARM: configs: keystone: sync to savedefconfig
  ARM: configs: keystone: Add basic systemd related options

 arch/arm/configs/keystone_defconfig | 54 ++++++++++++++++++-------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

-- 
2.1.4
