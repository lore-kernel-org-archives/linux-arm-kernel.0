From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 15 Oct 2013 17:49:37 -0700
Subject: [PATCH 9/9] KVM: ARM: Remove non-ASCII space characters
In-Reply-To: <1381884577-24747-1-git-send-email-christoffer.dall@linaro.org>
References: <1381884577-24747-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1381884577-24747-10-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some strange character leaped into the documentation, which makes
git-send-email behave quite strangely.  Get rid of this before it bites
anyone else.

Cc: Anup Patel <anup.patel@linaro.org>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 Documentation/virtual/kvm/api.txt |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index 076b849..a89a5ee 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -2312,7 +2312,7 @@ Type: vm ioctl
 Parameters: struct struct kvm_vcpu_init (out)
 Returns: 0 on success; -1 on error
 Errors:
-  ENODEV:    no preferred target available for the host
+  ENODEV:    no preferred target available for the host
 
 This queries KVM for preferred CPU target type which can be emulated
 by KVM on underlying host.
-- 
1.7.10.4
