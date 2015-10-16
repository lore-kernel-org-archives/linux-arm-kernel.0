From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Fri, 16 Oct 2015 16:22:09 +0100
Subject: [PATCH v4 3/3] arm64: defconfig: Enable PCI generic host bridge by
 default
In-Reply-To: <1445008929-32267-1-git-send-email-Liviu.Dudau@arm.com>
References: <1445008929-32267-1-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <1445008929-32267-4-git-send-email-Liviu.Dudau@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that pci-host-generic can be used under arm64, enable it by
default so that SBSA compliant systems can use it.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 34d71dd..7c9455a 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -49,6 +49,7 @@ CONFIG_ARCH_XGENE=y
 CONFIG_ARCH_ZYNQMP=y
 CONFIG_PCI=y
 CONFIG_PCI_MSI=y
+CONFIG_PCI_HOST_GENERIC=y
 CONFIG_PCI_XGENE=y
 CONFIG_SMP=y
 CONFIG_PREEMPT=y
-- 
2.6.0
