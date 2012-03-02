From: robherring2@gmail.com (Rob Herring)
Date: Thu,  1 Mar 2012 21:13:28 -0600
Subject: [PATCH v3 16/30] ARM: clps711x: remove unneeded include of mach/io.h
In-Reply-To: <1330658022-14559-1-git-send-email-robherring2@gmail.com>
References: <1330658022-14559-1-git-send-email-robherring2@gmail.com>
Message-ID: <1330658022-14559-17-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

In preparation to remove mach/io.h, remove an unneeded include of it.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/mach-clps711x/include/mach/uncompress.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-clps711x/include/mach/uncompress.h b/arch/arm/mach-clps711x/include/mach/uncompress.h
index 7164310..35ed731 100644
--- a/arch/arm/mach-clps711x/include/mach/uncompress.h
+++ b/arch/arm/mach-clps711x/include/mach/uncompress.h
@@ -17,7 +17,6 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
-#include <mach/io.h>
 #include <mach/hardware.h>
 #include <asm/hardware/clps7111.h>
 
-- 
1.7.5.4
