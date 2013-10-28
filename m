From: davidb@codeaurora.org (David Brown)
Date: Mon, 28 Oct 2013 13:43:23 -0700
Subject: [PATCH 1/4] ARM: msm: Remove unused board files
In-Reply-To: <1382993006-27359-1-git-send-email-davidb@codeaurora.org>
References: <1382993006-27359-1-git-send-email-davidb@codeaurora.org>
Message-ID: <1382993006-27359-2-git-send-email-davidb@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These board files were added in 2010, and have never been compiled in
the tree.  If these targets were to be included, at this point, they
would need to be done using device tree, so there is no reason to keep
these files around.

Signed-off-by: David Brown <davidb@codeaurora.org>
---
Note that this patch was made with -D.  I can send the full patch on
request, and have also made the tree available at: 

  git://git.kernel.org/pub/scm/linux/kernel/git/davidb/linux-msm.git for-3.14/big-cleanup

 arch/arm/mach-msm/board-mahimahi.c |  88 ----------------------------
 arch/arm/mach-msm/board-sapphire.c | 117 -------------------------------------
 2 files changed, 205 deletions(-)
 delete mode 100644 arch/arm/mach-msm/board-mahimahi.c
 delete mode 100644 arch/arm/mach-msm/board-sapphire.c

diff --git a/arch/arm/mach-msm/board-mahimahi.c b/arch/arm/mach-msm/board-mahimahi.c
deleted file mode 100644
index 7d9981c..0000000
diff --git a/arch/arm/mach-msm/board-sapphire.c b/arch/arm/mach-msm/board-sapphire.c
deleted file mode 100644
index 3276051..0000000
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
