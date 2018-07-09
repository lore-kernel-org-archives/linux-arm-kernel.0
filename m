From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon,  9 Jul 2018 08:30:33 -0700
Subject: [GIT PULL 4/6] Broadcom devicetree-arm64 changes for 4.19
In-Reply-To: <20180709153035.6376-1-f.fainelli@gmail.com>
References: <20180709153035.6376-1-f.fainelli@gmail.com>
Message-ID: <20180709153035.6376-4-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the git repository at:

  https://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.19/devicetree-arm64

for you to fetch changes up to a0061fc283bc4f8ac5f7f4b717ca089100124518:

  arm64: dts: Update Stingray clock DT nodes (2018-06-26 15:40:12 -0700)

----------------------------------------------------------------
This pull request contains Broadcom ARM64-based SoCs Device Tree changes
for 4.19, please pull the following:

- Scott does a bunch of updates to the Stingray DTS and DTS include
  files to better support the addition of new boards. Scott also adds
  the Stingray OTP Device Tree node

- Pramod updates the Stingray clocks such that they match the latest
  revision of the ASIC and datasheets

----------------------------------------------------------------
Pramod Kumar (1):
      arm64: dts: Update Stingray clock DT nodes

Scott Branden (2):
      arm64: dts: stingray: move common board components to stingray-board-base
      arm64: dts: stingray: Add OTP device node

 .../boot/dts/broadcom/stingray/bcm958742-base.dtsi | 35 +--------------
 .../dts/broadcom/stingray/stingray-board-base.dtsi | 51 ++++++++++++++++++++++
 .../boot/dts/broadcom/stingray/stingray-clock.dtsi | 26 ++++++++---
 .../arm64/boot/dts/broadcom/stingray/stingray.dtsi |  7 +++
 4 files changed, 78 insertions(+), 41 deletions(-)
 create mode 100644 arch/arm64/boot/dts/broadcom/stingray/stingray-board-base.dtsi
