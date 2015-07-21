From: jszhang@marvell.com (Jisheng Zhang)
Date: Tue, 21 Jul 2015 22:43:59 +0800
Subject: [PATCH 2/3] arm64: dts: cavium: remove paragraph about writing to FSF
In-Reply-To: <1437489840-2368-1-git-send-email-jszhang@marvell.com>
References: <1437489840-2368-1-git-send-email-jszhang@marvell.com>
Message-ID: <1437489840-2368-3-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove paragraph about writing to the Free Software Foundation's
mailing address from GPL notice.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 arch/arm64/boot/dts/cavium/thunder-88xx.dts  | 5 -----
 arch/arm64/boot/dts/cavium/thunder-88xx.dtsi | 5 -----
 2 files changed, 10 deletions(-)

diff --git a/arch/arm64/boot/dts/cavium/thunder-88xx.dts b/arch/arm64/boot/dts/cavium/thunder-88xx.dts
index 800ba65..c45039a 100644
--- a/arch/arm64/boot/dts/cavium/thunder-88xx.dts
+++ b/arch/arm64/boot/dts/cavium/thunder-88xx.dts
@@ -18,11 +18,6 @@
  *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *     GNU General Public License for more details.
  *
- *     You should have received a copy of the GNU General Public
- *     License along with this library; if not, write to the Free
- *     Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
- *     MA 02110-1301 USA
- *
  * Or, alternatively,
  *
  *  b) Permission is hereby granted, free of charge, to any person
diff --git a/arch/arm64/boot/dts/cavium/thunder-88xx.dtsi b/arch/arm64/boot/dts/cavium/thunder-88xx.dtsi
index 9cb7cf9..40b6714 100644
--- a/arch/arm64/boot/dts/cavium/thunder-88xx.dtsi
+++ b/arch/arm64/boot/dts/cavium/thunder-88xx.dtsi
@@ -18,11 +18,6 @@
  *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *     GNU General Public License for more details.
  *
- *     You should have received a copy of the GNU General Public
- *     License along with this library; if not, write to the Free
- *     Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
- *     MA 02110-1301 USA
- *
  * Or, alternatively,
  *
  *  b) Permission is hereby granted, free of charge, to any person
-- 
2.1.4
