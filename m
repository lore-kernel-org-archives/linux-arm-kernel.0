From: jnair@caviumnetworks.com (Jayachandran C)
Date: Mon, 22 May 2017 07:36:03 +0000
Subject: [PATCH 0/2] ARCH_VULCAN removal
Message-ID: <1495438565-82495-1-git-send-email-jnair@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Another couple of patches to remove more of ARCH_VULCAN platform.

There is still a reference in drivers/gpio/Kconfig for ARCH_VULCAN.
I am sending a patch to remove that, and after that we can completely
remove ARCH_VULCAN.

JC.

Jayachandran C (2):
  arm64: disable Broadcom Vulcan platform
  arm64: defconfig: drop ARCH_VULCAN

 arch/arm64/Kconfig.platforms | 5 +----
 arch/arm64/configs/defconfig | 1 -
 2 files changed, 1 insertion(+), 5 deletions(-)

-- 
2.7.4
