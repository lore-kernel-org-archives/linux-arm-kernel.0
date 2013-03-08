From: gang.chen@asianux.com (Chen Gang)
Date: Fri, 08 Mar 2013 18:32:40 +0800
Subject: [PATCH] ARM:kernel: beautify code: correct the tabs count for '}'
Message-ID: <5139BE48.4010602@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


  the '}' for 'function' and 'for', need be with correct tabs count

Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/arm/kernel/kprobes-common.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/kprobes-common.c b/arch/arm/kernel/kprobes-common.c
index 18a7628..17faa7c 100644
--- a/arch/arm/kernel/kprobes-common.c
+++ b/arch/arm/kernel/kprobes-common.c
@@ -574,5 +574,5 @@ kprobe_decode_insn(kprobe_opcode_t insn, struct arch_specific_insn *asi,
 		default:
 			return INSN_REJECTED;
 		}
-		}
 	}
+}
-- 
1.7.7.6
