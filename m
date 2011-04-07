From: tixy@yxit.co.uk (Tixy)
Date: Thu,  7 Apr 2011 13:25:18 +0100
Subject: [PATCH 4/5] ARM: kprobes: Fix error in comment
In-Reply-To: <1302179119-17573-1-git-send-email-tixy@yxit.co.uk>
References: <1302179119-17573-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1302179119-17573-5-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes-decode.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/kprobes-decode.c b/arch/arm/kernel/kprobes-decode.c
index 32401f8..03f7257 100644
--- a/arch/arm/kernel/kprobes-decode.c
+++ b/arch/arm/kernel/kprobes-decode.c
@@ -1069,7 +1069,7 @@ space_cccc_000x(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 			return prep_emulate_rd16rs8rm0_wflags(insn, asi);
 
 		/* SMLAxy : cccc 0001 0000 xxxx xxxx xxxx 1xx0 xxxx : Q */
-		/* SMLAWy : cccc 0001 0010 xxxx xxxx xxxx 0x00 xxxx : Q */
+		/* SMLAWy : cccc 0001 0010 xxxx xxxx xxxx 1x00 xxxx : Q */
 		return prep_emulate_rd16rn12rs8rm0_wflags(insn, asi);
 
 	}
-- 
1.7.2.5
