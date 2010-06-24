From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 24 Jun 2010 15:49:30 +0200
Subject: [PATCH 34/61] ARM: mxc: remove paragraphs with old address of the FSF
In-Reply-To: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1277387397-3467-35-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the kernel contains a copy of the GPL anyhow just get rid of the address
specification instead of fixing it.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/plat-mxc/audmux-v1.c                   |    4 ----
 arch/arm/plat-mxc/audmux-v2.c                   |    4 ----
 arch/arm/plat-mxc/ehci.c                        |    4 ----
 arch/arm/plat-mxc/include/mach/iomux-mxc91231.h |    4 ----
 arch/arm/plat-mxc/include/mach/mx3_camera.h     |    4 ----
 arch/arm/plat-mxc/include/mach/mxc91231.h       |    4 ----
 arch/arm/plat-mxc/include/mach/system.h         |    4 ----
 arch/arm/plat-mxc/include/mach/timex.h          |    4 ----
 arch/arm/plat-mxc/include/mach/uncompress.h     |    4 ----
 arch/arm/plat-mxc/include/mach/vmalloc.h        |    4 ----
 arch/arm/plat-mxc/system.c                      |    4 ----
 11 files changed, 0 insertions(+), 44 deletions(-)

diff --git a/arch/arm/plat-mxc/audmux-v1.c b/arch/arm/plat-mxc/audmux-v1.c
index b62917c..1180bef 100644
--- a/arch/arm/plat-mxc/audmux-v1.c
+++ b/arch/arm/plat-mxc/audmux-v1.c
@@ -13,10 +13,6 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
 #include <linux/module.h>
diff --git a/arch/arm/plat-mxc/audmux-v2.c b/arch/arm/plat-mxc/audmux-v2.c
index 0c2cc5c..1b5e4df 100644
--- a/arch/arm/plat-mxc/audmux-v2.c
+++ b/arch/arm/plat-mxc/audmux-v2.c
@@ -13,10 +13,6 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
 #include <linux/module.h>
diff --git a/arch/arm/plat-mxc/ehci.c b/arch/arm/plat-mxc/ehci.c
index 2a86461..6cedd5d 100644
--- a/arch/arm/plat-mxc/ehci.c
+++ b/arch/arm/plat-mxc/ehci.c
@@ -11,10 +11,6 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
  * or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
  * for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software Foundation,
- * Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
 #include <linux/platform_device.h>
diff --git a/arch/arm/plat-mxc/include/mach/iomux-mxc91231.h b/arch/arm/plat-mxc/include/mach/iomux-mxc91231.h
index 3887f3f..15d5951 100644
--- a/arch/arm/plat-mxc/include/mach/iomux-mxc91231.h
+++ b/arch/arm/plat-mxc/include/mach/iomux-mxc91231.h
@@ -12,10 +12,6 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
 #ifndef __MACH_IOMUX_MXC91231_H__
diff --git a/arch/arm/plat-mxc/include/mach/mx3_camera.h b/arch/arm/plat-mxc/include/mach/mx3_camera.h
index 36d7ff2..f226ee3 100644
--- a/arch/arm/plat-mxc/include/mach/mx3_camera.h
+++ b/arch/arm/plat-mxc/include/mach/mx3_camera.h
@@ -12,10 +12,6 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
 #ifndef _MX3_CAMERA_H_
diff --git a/arch/arm/plat-mxc/include/mach/mxc91231.h b/arch/arm/plat-mxc/include/mach/mxc91231.h
index 5182b98..0ca3101 100644
--- a/arch/arm/plat-mxc/include/mach/mxc91231.h
+++ b/arch/arm/plat-mxc/include/mach/mxc91231.h
@@ -13,10 +13,6 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 #ifndef __MACH_MXC91231_H__
 #define __MACH_MXC91231_H__
diff --git a/arch/arm/plat-mxc/include/mach/system.h b/arch/arm/plat-mxc/include/mach/system.h
index ef00199..4acd114 100644
--- a/arch/arm/plat-mxc/include/mach/system.h
+++ b/arch/arm/plat-mxc/include/mach/system.h
@@ -12,10 +12,6 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
 #ifndef __ASM_ARCH_MXC_SYSTEM_H__
diff --git a/arch/arm/plat-mxc/include/mach/timex.h b/arch/arm/plat-mxc/include/mach/timex.h
index 024416e..2d96246 100644
--- a/arch/arm/plat-mxc/include/mach/timex.h
+++ b/arch/arm/plat-mxc/include/mach/timex.h
@@ -11,10 +11,6 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
 #ifndef __ASM_ARCH_MXC_TIMEX_H__
diff --git a/arch/arm/plat-mxc/include/mach/uncompress.h b/arch/arm/plat-mxc/include/mach/uncompress.h
index b6d3d0f..d9bd37e 100644
--- a/arch/arm/plat-mxc/include/mach/uncompress.h
+++ b/arch/arm/plat-mxc/include/mach/uncompress.h
@@ -13,10 +13,6 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 #ifndef __ASM_ARCH_MXC_UNCOMPRESS_H__
 #define __ASM_ARCH_MXC_UNCOMPRESS_H__
diff --git a/arch/arm/plat-mxc/include/mach/vmalloc.h b/arch/arm/plat-mxc/include/mach/vmalloc.h
index 44243a2..ef6379c 100644
--- a/arch/arm/plat-mxc/include/mach/vmalloc.h
+++ b/arch/arm/plat-mxc/include/mach/vmalloc.h
@@ -11,10 +11,6 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
 #ifndef __ASM_ARCH_MXC_VMALLOC_H__
diff --git a/arch/arm/plat-mxc/system.c b/arch/arm/plat-mxc/system.c
index 97f4279..925bce4 100644
--- a/arch/arm/plat-mxc/system.c
+++ b/arch/arm/plat-mxc/system.c
@@ -14,10 +14,6 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
 #include <linux/kernel.h>
-- 
1.7.1
