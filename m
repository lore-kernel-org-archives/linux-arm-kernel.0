From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 24 Jun 2010 15:49:29 +0200
Subject: [PATCH 33/61] ARM: mxc91231: remove paragraphs with old address of
	the FSF
In-Reply-To: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1277387397-3467-34-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the kernel contains a copy of the GPL anyhow just get rid of the address
specification instead of fixing it.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mxc91231/crm_regs.h |    5 -----
 arch/arm/mach-mxc91231/mm.c       |    5 -----
 2 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-mxc91231/crm_regs.h b/arch/arm/mach-mxc91231/crm_regs.h
index ce4f590..b989bac 100644
--- a/arch/arm/mach-mxc91231/crm_regs.h
+++ b/arch/arm/mach-mxc91231/crm_regs.h
@@ -11,11 +11,6 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- *
  */
 
 #ifndef _ARCH_ARM_MACH_MXC91231_CRM_REGS_H_
diff --git a/arch/arm/mach-mxc91231/mm.c b/arch/arm/mach-mxc91231/mm.c
index 1f23c74..aeccfd7 100644
--- a/arch/arm/mach-mxc91231/mm.c
+++ b/arch/arm/mach-mxc91231/mm.c
@@ -15,11 +15,6 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- *
  */
 
 #include <linux/mm.h>
-- 
1.7.1
