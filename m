From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sat, 20 Feb 2016 11:46:27 -0800
Subject: [GIT PULL 8/8] Broadcom defconfig-arm64 changes for 4.6
In-Reply-To: <1455997587-17564-1-git-send-email-f.fainelli@gmail.com>
References: <1455997587-17564-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1455997587-17564-8-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.6/defconfig-arm64

for you to fetch changes up to 4cf430ee0c2ba1da97cab10b904291eb6fc5f170:

  arm64: defconfig: Add Broadcom Vulcan to defconfig (2016-02-20 10:42:08 -0800)

----------------------------------------------------------------
This pull request contains ARM64 defconfig changes for Broadcom SoCs:

- Jayachandran C enables the newly introduced Broadcom Vulcan SoC to the ARM64
  defconfig

----------------------------------------------------------------
Jayachandran C (1):
      arm64: defconfig: Add Broadcom Vulcan to defconfig

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)
