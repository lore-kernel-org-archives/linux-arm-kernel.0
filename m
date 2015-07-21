From: jszhang@marvell.com (Jisheng Zhang)
Date: Tue, 21 Jul 2015 22:43:58 +0800
Subject: [PATCH 1/3] arm64: hugetlb: remove paragraph about writing to FSF
In-Reply-To: <1437489840-2368-1-git-send-email-jszhang@marvell.com>
References: <1437489840-2368-1-git-send-email-jszhang@marvell.com>
Message-ID: <1437489840-2368-2-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove paragraph about writing to the Free Software Foundation's
mailing address from GPL notice.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 arch/arm64/include/asm/hugetlb.h | 4 ----
 arch/arm64/mm/hugetlbpage.c      | 4 ----
 2 files changed, 8 deletions(-)

diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
index 2fd9b14..bb4052e 100644
--- a/arch/arm64/include/asm/hugetlb.h
+++ b/arch/arm64/include/asm/hugetlb.h
@@ -13,10 +13,6 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
  */
 
 #ifndef __ASM_HUGETLB_H
diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 831ec53..383b03f 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -13,10 +13,6 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
  */
 
 #include <linux/init.h>
-- 
2.1.4
