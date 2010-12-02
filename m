From: will.deacon@arm.com (Will Deacon)
Date: Thu,  2 Dec 2010 13:46:00 +0000
Subject: [PATCH 09/11] ARM: ptrace: fix style issue with hw_breakpoint
	interface
In-Reply-To: <1291297562-8052-1-git-send-email-will.deacon@arm.com>
References: <1291297562-8052-1-git-send-email-will.deacon@arm.com>
Message-ID: <1291297562-8052-10-git-send-email-will.deacon@arm.com>
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
