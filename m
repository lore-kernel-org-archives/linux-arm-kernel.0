From: nathan_lynch@mentor.com (Nathan Lynch)
Date: Mon,  3 Feb 2014 13:48:50 -0600
Subject: [PATCH 0/2] arm64: vdso fixes for coarse clocks
Message-ID: <1391456932-17815-1-git-send-email-nathan_lynch@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While working on vdso for 32-bit ARM I have referred heavily to the
arm64 implementation.  In arm64 I found a couple of issues with the
handling of CLOCK_MONOTONIC_COARSE and CLOCK_REALTIME_COARSE,
which are addressed in this series.

Nathan Lynch (2):
  arm64: vdso: fix coarse clock handling
  arm64: vdso: update wtm fields for CLOCK_MONOTONIC_COARSE

 arch/arm64/kernel/vdso.c              | 4 ++--
 arch/arm64/kernel/vdso/gettimeofday.S | 9 ++++++---
 2 files changed, 8 insertions(+), 5 deletions(-)

-- 
1.8.3.1
