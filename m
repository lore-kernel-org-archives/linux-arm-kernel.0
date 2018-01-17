From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Wed, 17 Jan 2018 17:42:18 +0000
Subject: [PATCH v2 0/2] arm64: Run enable method for errata work arounds on
 late CPUs
Message-ID: <20180117174220.7959-1-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This v2 of the patch posted here [1]. Following the discussion there,
I have included a patch (Patch 1) to clarify the argument passed to @enable()
call back for a capability. Original patch (Patch 2) is unchanged.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-January/554578.html


Suzuki K Poulose (2):
  arm64: capabilities: Clarify argument passed to enable call back
  arm64: Run enable method for errata work arounds on late CPUs

 arch/arm64/include/asm/cpufeature.h | 9 ++++++++-
 arch/arm64/kernel/cpu_errata.c      | 9 ++++++---
 2 files changed, 14 insertions(+), 4 deletions(-)

-- 
2.13.6
