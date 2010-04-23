From: tony@atomide.com (Tony Lindgren)
Date: Fri, 23 Apr 2010 16:11:53 -0700
Subject: [PATCH 21/28] n8x0_defconfig: remove CONFIG_NILFS2_FS override
In-Reply-To: <20100423230829.31953.17334.stgit@baageli.muru.com>
References: <20100423230829.31953.17334.stgit@baageli.muru.com>
Message-ID: <20100423231153.31953.61218.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Francisco Alecrim <francisco.alecrim@openbossa.org>

arch/arm/configs/n8x0_defconfig:1061:warning: override: reassigning to
symbol NILFS2_FS

Signed-off-by: Francisco Alecrim <francisco.alecrim@openbossa.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/n8x0_defconfig |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/configs/n8x0_defconfig b/arch/arm/configs/n8x0_defconfig
index 216ad00..9405e32 100644
--- a/arch/arm/configs/n8x0_defconfig
+++ b/arch/arm/configs/n8x0_defconfig
@@ -1058,7 +1058,6 @@ CONFIG_JFFS2_CMODE_PRIORITY=y
 # CONFIG_ROMFS_FS is not set
 # CONFIG_SYSV_FS is not set
 # CONFIG_UFS_FS is not set
-# CONFIG_NILFS2_FS is not set
 CONFIG_NETWORK_FILESYSTEMS=y
 # CONFIG_NFS_FS is not set
 # CONFIG_NFSD is not set
