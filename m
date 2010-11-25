From: will.deacon@arm.com (Will Deacon)
Date: Thu, 25 Nov 2010 17:08:19 +0000
Subject: [PATCH 4/4] ARM: ptrace: fix style issue with hw_breakpoint interface
In-Reply-To: <1290704899-13051-1-git-send-email-will.deacon@arm.com>
References: <1290704899-13051-1-git-send-email-will.deacon@arm.com>
Message-ID: <1290704899-13051-5-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes a trivial style issue in ptrace.c.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/ptrace.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index 3e97483..19c6816 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -1060,8 +1060,8 @@ static int ptrace_sethbpregs(struct task_struct *tsk, long num,
 			goto out;
 
 		if ((gen_type & implied_type) != gen_type) {
-				ret = -EINVAL;
-				goto out;
+			ret = -EINVAL;
+			goto out;
 		}
 
 		attr.bp_len	= gen_len;
-- 
1.7.0.4
