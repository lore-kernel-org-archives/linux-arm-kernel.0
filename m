From: anup.patel@linaro.org (Anup Patel)
Date: Thu, 12 Dec 2013 21:42:24 +0530
Subject: =?UTF-8?q?=5BPATCH=5D=20KVM=3A=20Documentation=3A=20Fix=20typo=20for=20KVM=5FARM=5FVCPU=5FINIT=20ioctl?=
In-Reply-To: <1386864747-29006-1-git-send-email-anup.patel@linaro.org>
References: <1386864747-29006-1-git-send-email-anup.patel@linaro.org>
Message-ID: <1386864747-29006-3-git-send-email-anup.patel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix minor typo in "Parameters:" of KVM_ARM_VCPU_INIT documentation.

Signed-off-by: Anup Patel <anup.patel@linaro.org>
Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
---
 Documentation/virtual/kvm/api.txt |    2 +-
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
1.7.9.5
