From: xuwei5@hisilicon.com (Wei Xu)
Date: Wed, 18 Jul 2018 16:46:53 +0100
Subject: [GIT PULL] arm64: defconfig: hisilicon config updates for v4.19
Message-ID: <5B4F60ED.2070106@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Arnd,

Please consider to pull the following changes.
Thanks!

Best Regards,
Wei

---

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  git://github.com/hisilicon/linux-hisi.git tags/hisi-defconfig-for-4.19

for you to fetch changes up to cc4493faf494bb8af2324b1b7cabd1f1457a76ca:

  arm64: defconfig: enable HiSilicon PMU driver (2018-07-17 14:06:16 +0100)

----------------------------------------------------------------
ARM64: hisilicon: defconfig updates for 4.18

- Enable uncore pmu for some hisilicon SoCs

----------------------------------------------------------------
Zhou Wang (1):
      arm64: defconfig: enable HiSilicon PMU driver

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)
