From: bhupesh.sharma@freescale.com (Bhupesh Sharma)
Date: Sat, 24 Oct 2015 01:01:59 +0530
Subject: [PATCH v4 10/12] dts/ls2080a: Remove text about writing to Free
 Software Foundation
In-Reply-To: <1445628721-10483-1-git-send-email-bhupesh.sharma@freescale.com>
References: <1445628721-10483-1-git-send-email-bhupesh.sharma@freescale.com>
Message-ID: <1445628721-10483-11-git-send-email-bhupesh.sharma@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Checkpatch complains about the text suggesting writing to
Free Software Foundation for GPLv2 license copy.

This patch removes the same from the .dtsi and .dts

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls2080a-simu.dts |    5 -----
 arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi     |    5 -----
 2 files changed, 10 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2080a-simu.dts b/arch/arm64/boot/dts/freescale/fsl-ls2080a-simu.dts
index 3676c02..505d038 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls2080a-simu.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls2080a-simu.dts
@@ -20,11 +20,6 @@
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
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
index 7247ea4..3b2a679 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
@@ -20,11 +20,6 @@
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
1.7.9.5
