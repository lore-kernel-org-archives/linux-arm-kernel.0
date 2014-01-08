From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed,  8 Jan 2014 14:47:27 -0800
Subject: [PATCH 2/5] KVM: Documentation: Fix typo for KVM_ARM_VCPU_INIT ioctl
In-Reply-To: <1389221250-30034-1-git-send-email-christoffer.dall@linaro.org>
References: <1389221250-30034-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1389221250-30034-3-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Anup Patel <anup.patel@linaro.org>

Fix minor typo in "Parameters:" of KVM_ARM_VCPU_INIT documentation.

Signed-off-by: Anup Patel <anup.patel@linaro.org>
Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 Documentation/virtual/kvm/api.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index a30035d..aad3244 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -2327,7 +2327,7 @@ current state.  "addr" is ignored.
 Capability: basic
 Architectures: arm, arm64
 Type: vcpu ioctl
-Parameters: struct struct kvm_vcpu_init (in)
+Parameters: struct kvm_vcpu_init (in)
 Returns: 0 on success; -1 on error
 Errors:
  ?EINVAL: ???the target is unknown, or the combination of features is invalid.
-- 
1.8.5.2
