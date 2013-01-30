From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 30 Jan 2013 14:42:39 -0700
Subject: [GIT PULL 8/8] ARM: tegra: defconfig update
In-Reply-To: <1359582159-28816-1-git-send-email-swarren@wwwdotorg.org>
References: <1359582159-28816-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1359582159-28816-8-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Various new features are enabled on Tegra:
* RTC_DRV_TPS6586X to enable the RTC on many boards, such as Harmony
  and Ventana.
* POWER_RESET_GPIO to provide a power off driver for TrimSlice.
* Tegra KBC controller support, for Seaboard, Harmony, and Whistler.
* Tegra high-speed UART driver, for Cardhu Bluetooth.
* kexec support.

This pull request is based on v3.8-rc3.

----------------------------------------------------------------

The following changes since commit 9931faca02c604c22335f5a935a501bb2ace6e20:

  Linux 3.8-rc3

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git tegra-for-3.9-defconfig

for you to fetch changes up to a05b0d505e76161b485db360f5eac5436e2fc2c6:

  ARM: tegra: defconfig updates

----------------------------------------------------------------

Laxman Dewangan (1):
      ARM: tegra: defconfig updates

 arch/arm/configs/tegra_defconfig |    6 ++++++
 1 file changed, 6 insertions(+)
