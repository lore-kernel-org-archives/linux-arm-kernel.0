From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 12 Jun 2017 10:31:08 -0700
Subject: [GIT PULL 4/5] Broadcom defconfig-arm64 changes for 4.13
In-Reply-To: <20170612173109.11188-1-f.fainelli@gmail.com>
References: <20170612173109.11188-1-f.fainelli@gmail.com>
Message-ID: <20170612173109.11188-4-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.13/defconfig-arm64

for you to fetch changes up to 747868aeb03b44ae4818c8fd3956fb606b09e58d:

  arm64: defconfig: Enable ARCH_BRCMSTB (2017-06-08 13:45:54 -0700)

----------------------------------------------------------------
This pull request contains ARM64 defconfig changes for 4.13, please pull the
following:

- Florian enables ARCH_BRCMSTB in the arm64 defconfig to get more build coverage

----------------------------------------------------------------
Florian Fainelli (1):
      arm64: defconfig: Enable ARCH_BRCMSTB

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)
