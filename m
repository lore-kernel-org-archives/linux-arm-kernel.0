From: hari.vyas@broadcom.com (Hari Vyas)
Date: Tue, 17 Jul 2018 15:01:20 +0530
Subject: [PATCH] arm64: fix kernel panic on serror caused by user process
Message-ID: <1531819881-2931-1-git-send-email-hari.vyas@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

changes in v1:
	Based on processor mode, action is taken i.e. for user mode, only
	user process is killed otherwise as usual kernel will panic and
	system halts.

Hari Vyas (1):
  arm64: fix kernel panic on serror exception caused by user process

 arch/arm64/kernel/traps.c | 7 +++++++
 1 file changed, 7 insertions(+)

-- 
1.9.1
