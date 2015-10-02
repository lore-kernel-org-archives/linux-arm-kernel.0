From: anup.patel@broadcom.com (Anup Patel)
Date: Fri, 2 Oct 2015 23:24:17 +0530
Subject: [PATCH 0/6] arm64: Simple additions to NS2 DT
Message-ID: <1443808463-21120-1-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We add l2-cache, SMMU, reboot, PMUv3, RNG, and I2C DT nodes
for NS2 SVK.

This patchset is based on v4.3-rc3 and available in ns2_dt1_v1
branch of https://github.com/Broadcom/arm64-linux.git.

The patchset is tested on NS2 SVK.

Anup Patel (5):
  arm64: dts: Add L2-cache DT node for NS2
  arm64: dts: Add SMMU DT node for NS2
  arm64: dts: Add syscon based reboot in DT for NS2
  arm64: dts: Add ARM PMUv3 DT node in NS2 DT
  arm64: dts: Add IPROC RNG200 DT node for NS2

Ray Jui (1):
  arm64: dts: Add I2C nodes for NS2

 arch/arm64/boot/dts/broadcom/ns2-svk.dts |   8 +++
 arch/arm64/boot/dts/broadcom/ns2.dtsi    | 106 +++++++++++++++++++++++++++++--
 2 files changed, 110 insertions(+), 4 deletions(-)

-- 
1.9.1
