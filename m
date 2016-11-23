From: vijay.kilari@gmail.com (vijay.kilari at gmail.com)
Date: Wed, 23 Nov 2016 18:31:55 +0530
Subject: [PATCH v9 08/11] arm/arm64: Documentation: Update arm-vgic-v3.txt
In-Reply-To: <1479906118-15832-1-git-send-email-vijay.kilari@gmail.com>
References: <1479906118-15832-1-git-send-email-vijay.kilari@gmail.com>
Message-ID: <1479906118-15832-9-git-send-email-vijay.kilari@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vijaya Kumar K <Vijaya.Kumar@cavium.com>

Update error code returned for Invalid CPU interface register
value.

Signed-off-by: Vijaya Kumar K <Vijaya.Kumar@cavium.com>
---
 Documentation/virtual/kvm/devices/arm-vgic-v3.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/virtual/kvm/devices/arm-vgic-v3.txt b/Documentation/virtual/kvm/devices/arm-vgic-v3.txt
index 9348b3c..bff2898 100644
--- a/Documentation/virtual/kvm/devices/arm-vgic-v3.txt
+++ b/Documentation/virtual/kvm/devices/arm-vgic-v3.txt
@@ -145,7 +145,7 @@ Groups:
   Errors:
     -ENXIO: Getting or setting this register is not yet supported
     -EBUSY: VCPU is running
-    -EINVAL: Invalid mpidr supplied
+    -EINVAL: Invalid mpidr or register value supplied
 
 
   KVM_DEV_ARM_VGIC_GRP_NR_IRQS
-- 
1.9.1
