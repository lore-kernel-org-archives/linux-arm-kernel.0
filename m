From: 21cnbao@gmail.com (Barry Song)
Date: Wed, 6 Mar 2013 23:01:12 +0800
Subject: [GIT PULL] ARM: CSR: minor fixes for 3.9-rc1
Message-ID: <CAGsJ_4zyW+jVwDZDTb3TwY9TL+pmub4KGP6K0pgwToa-M2kXxQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Arnd,

The following changes since commit 6dbe51c251a327e012439c4772097a13df43c5b8:

  Linux 3.9-rc1 (2013-03-03 15:11:05 -0800)

are available in the git repository at:
  git://gitorious.org/sirfprima2-kernel/sirfprima2-kernel.git sirf/fixes

Barry Song (1):
      ARM: prima2: fix a checkpatch issue

Syam Sidhardhan (1):
      ARM: prima2: Replace include linux/module.h with linux/export.h

 arch/arm/mach-prima2/common.c |    4 ++--
 arch/arm/mach-prima2/pm.c     |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

-----

diff --git a/arch/arm/mach-prima2/common.c b/arch/arm/mach-prima2/common.c
index 2d57aa4..2ed5007 100644
--- a/arch/arm/mach-prima2/common.c
+++ b/arch/arm/mach-prima2/common.c
@@ -39,8 +39,8 @@ static __init void sirfsoc_map_io(void)

 #ifdef CONFIG_ARCH_PRIMA2
 static const char *prima2_dt_match[] __initdata = {
-       "sirf,prima2",
-       NULL
+	"sirf,prima2",
+	NULL
 };

 DT_MACHINE_START(PRIMA2_DT, "Generic PRIMA2 (Flattened Device Tree)")
diff --git a/arch/arm/mach-prima2/pm.c b/arch/arm/mach-prima2/pm.c
index 9936c18..f7e347e 100644
--- a/arch/arm/mach-prima2/pm.c
+++ b/arch/arm/mach-prima2/pm.c
@@ -9,7 +9,7 @@
 #include <linux/kernel.h>
 #include <linux/suspend.h>
 #include <linux/slab.h>
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>


Thanks
barry
