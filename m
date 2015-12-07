From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon,  7 Dec 2015 15:57:26 -0800
Subject: [GIT PULL 4/4] Broadcom devicetree-arm64 changes for v4.5
Message-ID: <1449532649-6471-1-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:

  Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)

are available in the git repository at:

  http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.5/devicetree-arm64

for you to fetch changes up to d8bd64c1514ed5dca1c864b24a08d3314829eeb8:

  ARM64: dts: enable clock support for Broadcom NS2 (2015-11-20 10:15:42 -0800)

----------------------------------------------------------------
This pull request contains Broadcom ARM64-based Device Tree changes:

- Anup Patel adds L2 cache, SMMU, syscon-based reboot, PMU v3, iProc RNG200 (HWRNG) and
  NAND flash controller support to the Northstar 2 SoCs

- Ray Jui adds the I2C Device Tree nodes to the Norsthar 2 SoCs

- Jon Mason enables the clock providers on the Norsthar 2 SoCs

----------------------------------------------------------------
Anup Patel (6):
      arm64: dts: Add L2-cache DT node for NS2
      arm64: dts: Add SMMU DT node for NS2
      arm64: dts: Add syscon based reboot in DT for NS2
      arm64: dts: Add ARM PMUv3 DT node in NS2 DT
      arm64: dts: Add IPROC RNG200 DT node for NS2
      arm64: dts: Add BRCM IPROC NAND DT node for NS2

Jon Mason (1):
      ARM64: dts: enable clock support for Broadcom NS2

Ray Jui (1):
      arm64: dts: Add I2C nodes for NS2

 arch/arm64/boot/dts/broadcom/ns2-svk.dts |  26 +++-
 arch/arm64/boot/dts/broadcom/ns2.dtsi    | 200 ++++++++++++++++++++++++++++++-
 2 files changed, 217 insertions(+), 9 deletions(-)
