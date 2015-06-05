From: xuwei5@hisilicon.com (Wei Xu)
Date: Fri, 5 Jun 2015 17:01:59 +0100
Subject: [GIT PULL v2]Hisilicon 64-bit SoC changes for 4.2
Message-ID: <5571C7F7.9090702@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Hi Olof, Hi Kevin,

Please help to pull the following changes.
Sorry for the late pull request.
Thanks!

Best Regards,
Wei

---

The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:

  Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)

are available in the git repository at:

  git://github.com/hisilicon/linux-hisi.git tags/hi6220-soc-for-4.2

for you to fetch changes up to 85fe946e8c8485d868edcbdcef78f04e4a259a6a:

  arm64: Enable Hisilicon ARMv8 SoC family in Kconfig and defconfig (2015-06-05 16:01:17 +0100)

----------------------------------------------------------------
ARM64: Hisilicon ARM64 SoC Updates for V4.2

- Added Hisilicon ARM64 SoC family support in Kconfig and defconfig

----------------------------------------------------------------
Bintian Wang (1):
      arm64: Enable Hisilicon ARMv8 SoC family in Kconfig and defconfig

 arch/arm64/Kconfig           | 5 +++++
 arch/arm64/configs/defconfig | 1 +
 2 files changed, 6 insertions(+)
