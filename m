From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 17 Aug 2017 11:37:47 -0700
Subject: [GIT PULL 5/6] Broadcom defconfig-arm64 changes for 4.14
In-Reply-To: <20170817183748.1450-1-f.fainelli@gmail.com>
References: <20170817183748.1450-1-f.fainelli@gmail.com>
Message-ID: <20170817183748.1450-6-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.14/defconfig-arm64

for you to fetch changes up to d5512507716eff4594f337d58318a853d1ff94be:

  arm64: defconfig: add CONFIG_BRCMSTB_THERMAL (2017-08-15 10:21:37 -0700)

----------------------------------------------------------------
This pull request contains ARM64 defconfig changes for Broadcom ARM64-based
SoCs for 4.14, please pull the following:

- Markus enables the Broadcom STB AVS thermal monitoring driver as a module
  which is currently queued in Rui Zhang's tree

----------------------------------------------------------------
Markus Mayer (1):
      arm64: defconfig: add CONFIG_BRCMSTB_THERMAL

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)
