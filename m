From: xuwei5@hisilicon.com (Wei Xu)
Date: Fri, 2 Sep 2016 11:37:41 +0100
Subject: [GIT PULL] arm64: defconfig: hisilicon config updates for v4.9
Message-ID: <57C95675.5060504@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Hi Olof, Hi Kevin,

Please help to pull the following changes.
Thanks!

Best Regards,
Wei

---

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  git://github.com/hisilicon/linux-hisi.git tags/hisi-defconfig-for-4.9

for you to fetch changes up to 21adc4d7bb0260effe0a4395a8751d88a4aedf9a:

  Kconfig: ARCH_HISI: Add PINCTRL to HISI platform (2016-08-24 15:56:28 +0100)

----------------------------------------------------------------
ARM64: hisilicon: defconfig updates for 4.9

- Enable hisilicon SAS and XGE for hip05 and hip06
- Enable drm, powerkey, bluetooth and adv7511/adv7533 for hikey
- Add PINCTRL to HISI platform

----------------------------------------------------------------
Guodong Xu (3):
      arm64: defconfig: Enable HiSilicon kirin drm, adv7533 for HiKey
      arm64: defconfig: enable CONFIG_INPUT_HISI_POWERKEY for HiKey
      arm64: defconfig: enable bluetooth supports as modules

John Stultz (1):
      Kconfig: ARCH_HISI: Add PINCTRL to HISI platform

Kefeng Wang (1):
      arm64: defconfig: Enable Hisi SAS and HNS

 arch/arm64/Kconfig.platforms |  1 +
 arch/arm64/configs/defconfig | 16 +++++++++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)
