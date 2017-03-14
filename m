From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue, 14 Mar 2017 18:13:24 +0000
Subject: [PATCH 0/3] arm64: Advertise ARMv8.3 features
Message-ID: <1489515207-9233-1-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Advertise the ARMv8.3 features for the applications via ELF HWCAPS
and MRS emulation.

Suzuki K Poulose (3):
  arm64: v8.3: Support for Javascript conversion instruction
  arm64: v8.3: Support for complex number instructions
  arm64: v8.3: Support for weaker release consistency

 Documentation/arm64/cpu-feature-registers.txt | 12 ++++++++++++
 arch/arm64/include/asm/sysreg.h               |  5 +++++
 arch/arm64/include/uapi/asm/hwcap.h           |  3 +++
 arch/arm64/kernel/cpufeature.c                | 12 +++++++++++-
 arch/arm64/kernel/cpuinfo.c                   |  3 +++
 5 files changed, 34 insertions(+), 1 deletion(-)

-- 
2.7.4
