From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 26 Apr 2018 17:38:41 -0700
Subject: [GIT PULL] Broadcom devicetree-arm64 fixes for 4.17
Message-ID: <20180427003841.16217-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the git repository at:

  https://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.17/devicetree-arm64-fixes

for you to fetch changes up to 4555a5021fe88fc4f19ff53d1e58b410cf30a49a:

  arm64: dts: correct SATA addresses for Stingray (2018-04-18 11:31:16 -0700)

----------------------------------------------------------------
This pull request contains Broadcom ARM64-based SoCs Device Tree fixes
for 4.17, please pull the following:

- Srinath fixes the register base address of all SATA controllers on
  Stingray

----------------------------------------------------------------
Srinath Mannam (1):
      arm64: dts: correct SATA addresses for Stingray

 .../boot/dts/broadcom/stingray/stingray-sata.dtsi  | 80 +++++++++++-----------
 1 file changed, 40 insertions(+), 40 deletions(-)
