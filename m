From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Fri, 31 Oct 2014 16:04:19 +0000
Subject: [PATCH 2/3] arm64: Create link to include/dt-bindings to enable C
 preprocessor use.
In-Reply-To: <1414771460-7340-1-git-send-email-Liviu.Dudau@arm.com>
References: <1414771460-7340-1-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <1414771460-7340-3-git-send-email-Liviu.Dudau@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DT files used in the compilation phase can be preprocessed by the C
preprocessor. This requires an include/dt-bindings directory to be
present in the arch/arm64/boot/dts directory.

Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
---
 arch/arm64/boot/dts/include/dt-bindings | 1 +
 1 file changed, 1 insertion(+)
 create mode 120000 arch/arm64/boot/dts/include/dt-bindings

diff --git a/arch/arm64/boot/dts/include/dt-bindings b/arch/arm64/boot/dts/include/dt-bindings
new file mode 120000
index 0000000..08c00e4
--- /dev/null
+++ b/arch/arm64/boot/dts/include/dt-bindings
@@ -0,0 +1 @@
+../../../../../include/dt-bindings
\ No newline at end of file
-- 
2.1.2
