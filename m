From: larry.bassel@linaro.org (Larry Bassel)
Date: Sun, 27 Apr 2014 12:44:11 -0700
Subject: [PATCH 0/3] context tracker support for arm64
Message-ID: <1398627854-9617-1-git-send-email-larry.bassel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implement and enable context tracking for arm64 (which is
a prerequisite for FULL_NOHZ support). This patchset
builds upon earlier work by Kevin Hilman and is based on 3.15-rc2.

Kevin Hilman (1):
  arm64: add support for context tracking

Larry Bassel (2):
  arm64: adjust el0_sync so that a function can be called
  arm64: enable context tracking

 arch/arm64/Kconfig                   |  1 +
 arch/arm64/include/asm/thread_info.h |  1 +
 arch/arm64/kernel/entry.S            | 33 ++++++++++++++++++++++++++++-----
 3 files changed, 30 insertions(+), 5 deletions(-)

-- 
1.8.3.2
