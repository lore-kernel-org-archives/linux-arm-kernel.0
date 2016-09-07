From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue,  6 Sep 2016 18:59:16 -0700
Subject: [GIT PULL 2/4] Broadcom soc-arm64 changes for 4.9
In-Reply-To: <1473213558-11782-1-git-send-email-f.fainelli@gmail.com>
References: <1473213558-11782-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1473213558-11782-2-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.9/soc-arm64

for you to fetch changes up to 37eb56dc79a8e841f3801f9364de8a70189c306f:

  arm64: Add Broadcom Set Top Box Kconfig entry point (2016-08-08 11:11:53 -0700)

----------------------------------------------------------------
This pull request contains Broadcom ARM64-based SoC changes for 4.9, please pull
the following:

- collective effort from Florian, Doug and Markus to add the ARCH_BRCMSTB Kconfig
  symbol to the ARM64 kernel build, which is purposedly the same as the ARM/Linux
  one in order not to update any driver dependencies

----------------------------------------------------------------
Florian Fainelli (1):
      arm64: Add Broadcom Set Top Box Kconfig entry point

 arch/arm64/Kconfig.platforms | 7 +++++++
 1 file changed, 7 insertions(+)
