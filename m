From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Mon, 12 Mar 2018 10:04:12 +0000
Subject: [PATCH v3 0/2] arm64: Expose v8.4 features
Message-ID: <20180312100414.6809-1-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The series applies on arm64's for-next/core branch.

Changes since V2:
 - Dropped "arm64: Relax constraints on ID feature bits" patch
 - Add stand alone patch for removing RES0 fields from the documentation.
  (I have retained Dave's Reviewed-by, as the patch hasn't changed)

Suzuki K Poulose (2):
  arm64: Documentation: cpu-feature-registers: Remove RES0 fields
  arm64: Expose Arm v8.4 features

 Documentation/arm64/cpu-feature-registers.txt | 18 ++++++++++--------
 Documentation/arm64/elf_hwcaps.txt            | 16 ++++++++++++++++
 arch/arm64/include/asm/sysreg.h               |  3 +++
 arch/arm64/include/uapi/asm/hwcap.h           |  4 ++++
 arch/arm64/kernel/cpufeature.c                |  7 +++++++
 arch/arm64/kernel/cpuinfo.c                   |  4 ++++
 6 files changed, 44 insertions(+), 8 deletions(-)

-- 
2.14.3
