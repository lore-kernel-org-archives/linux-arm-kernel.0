From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 20 Oct 2017 17:16:35 -0700
Subject: [GIT PULL 4/5] Broadcom defconfig changes for 4.15
In-Reply-To: <20171021001636.17662-1-f.fainelli@gmail.com>
References: <20171021001636.17662-1-f.fainelli@gmail.com>
Message-ID: <20171021001636.17662-4-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.15/defconfig

for you to fetch changes up to 675a157c61f756affbbc2569c55dc5719342081b:

  ARM: multi_v7_defconfig: Enable CONFIG_ARCH_BCM_HR2 (2017-10-12 11:32:43 -0700)

----------------------------------------------------------------
This pull request contains Broadcom ARM-based SoCs multi_v7_defconfig file
updates for 4.15, please pull the following:

- Florian enables the Broadcom Hurricane 2 SoC in multi_v7_defconfig
  (CONFIG_ARCH_BCM_HR2)

----------------------------------------------------------------
Florian Fainelli (1):
      ARM: multi_v7_defconfig: Enable CONFIG_ARCH_BCM_HR2

 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)
