From: xuwei5@hisilicon.com (Wei Xu)
Date: Thu, 28 Dec 2017 21:21:18 +0000
Subject: [GIT PULL v2] arm64: dts: hisilicon dts updates for v4.16
In-Reply-To: <5A3CD3EE.7030505@hisilicon.com>
References: <5A3CD3EE.7030505@hisilicon.com>
Message-ID: <5A45604E.4050801@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Hi Olof, Hi Kevin,

Please help to pull the following changes.
Thanks!

Best Regards,
Wei

---

The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the git repository at:

  git://github.com/hisilicon/linux-hisi.git tags/hisi-arm64-dt-for-4.16-v2

for you to fetch changes up to 9a9760dede5c71e04b17b2ede594ee7148fd36e2:

  arm64: dts: hisilicon: Add hi3660 cpu capacity-dmips-mhz information (2017-12-22 09:11:42 +0000)

----------------------------------------------------------------
ARM64: DT: Hisilicon SoC DT updates for 4.16

- Add SD card support for the hi3798cv200-poplar board
- Replace the PMU node with exact match for the hi3660 SoC
- Add cpu capacity-dmips-mhz information for the hi3660 SoC

----------------------------------------------------------------
Shawn Guo (1):
      arm64: dts: hi3798cv200: add SD card support

Valentin Schneider (1):
      arm64: dts: hisilicon: Add hi3660 cpu capacity-dmips-mhz information

Xu YiPing (1):
      arm64: dts: hi3660: improve pmu description

 arch/arm64/boot/dts/hisilicon/hi3660.dtsi          | 30 +++++++++++++++-------
 .../boot/dts/hisilicon/hi3798cv200-poplar.dts      |  6 +++++
 arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi     | 12 +++++++++
 3 files changed, 39 insertions(+), 9 deletions(-)
