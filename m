From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon,  5 May 2014 16:17:07 +0200
Subject: [PATCH] ARM: mvebu: fix for mvebu/soc-cpuidle branch
Message-ID: <1399299428-30690-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Jason,

In the merge of the Armada 375/38x I/O coherency support and the
Armada XP cpuidle support, there was a conflict in coherency.c which
was resolved correctly.

This commit fixes this invalid merge. It applies on top of your
mvebu/soc-cpuidle branch.

Thanks,

Thomas

Thomas Petazzoni (1):
  ARM: mvebu: fix mis-merge in coherency.c

 arch/arm/mach-mvebu/coherency.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

-- 
1.9.2
