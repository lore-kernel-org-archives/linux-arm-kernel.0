From: larry.bassel@linaro.org (Larry Bassel)
Date: Tue,  6 May 2014 16:32:27 -0700
Subject: [PATCH v2 0/2] context tracker support for arm64
Message-ID: <1399419149-26685-1-git-send-email-larry.bassel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implement and enable context tracking for arm64 (which is
a prerequisite for FULL_NOHZ support). This patchset
builds upon earlier work by Kevin Hilman and is based on 3.15-rc2.

Larry Bassel (2):
  arm64: adjust el0_sync so that a function can be called
  arm64: enable context tracking

 arch/arm64/Kconfig                   |  1 +
 arch/arm64/include/asm/thread_info.h |  1 +
 arch/arm64/kernel/entry.S            | 36 +++++++++++++++++++++++++++++++-----
 3 files changed, 33 insertions(+), 5 deletions(-)

-- 
1.8.3.2
