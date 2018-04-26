From: will.deacon@arm.com (Will Deacon)
Date: Thu, 26 Apr 2018 11:34:28 +0100
Subject: [PATCH v3 14/14] MAINTAINERS: Add myself as a co-maintainer for
 LOCKING PRIMITIVES
In-Reply-To: <1524738868-31318-1-git-send-email-will.deacon@arm.com>
References: <1524738868-31318-1-git-send-email-will.deacon@arm.com>
Message-ID: <1524738868-31318-15-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I've been heavily involved with concurrency and memory ordering stuff
(see ATOMIC INFRASTRUCTURE and LINUX KERNEL MEMORY CONSISTENCY MODEL)
and with arm64 now using qrwlock with a view to using qspinlock in the
near future, I'm going to continue being involved with the core locking
primitives. Reflect this by adding myself as a co-maintainer alongside
Ingo and Peter.

Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 92be777d060a..2509c20a979e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8328,6 +8328,7 @@ F:	Documentation/admin-guide/LSM/LoadPin.rst
 LOCKING PRIMITIVES
 M:	Peter Zijlstra <peterz@infradead.org>
 M:	Ingo Molnar <mingo@redhat.com>
+M:	Will Deacon <will.deacon@arm.com>
 L:	linux-kernel at vger.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
 S:	Maintained
-- 
2.1.4
