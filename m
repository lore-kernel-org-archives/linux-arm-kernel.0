From: alex.bennee@linaro.org (=?UTF-8?q?Alex=20Benn=C3=A9e?=)
Date: Tue, 25 Nov 2014 16:09:59 +0000
Subject: [PATCH 1/7] KVM: add commentary for kvm_debug_exit_arch struct
In-Reply-To: <1416931805-23223-1-git-send-email-alex.bennee@linaro.org>
References: <1416931805-23223-1-git-send-email-alex.bennee@linaro.org>
Message-ID: <1416931805-23223-2-git-send-email-alex.bennee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bring into line with the commentary for the other structures and their
KVM_EXIT_* cases.

Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>

diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 6076882..523f476 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -226,6 +226,7 @@ struct kvm_run {
 			__u32 count;
 			__u64 data_offset; /* relative to kvm_run start */
 		} io;
+		/* KVM_EXIT_DEBUG */
 		struct {
 			struct kvm_debug_exit_arch arch;
 		} debug;
-- 
2.1.3
