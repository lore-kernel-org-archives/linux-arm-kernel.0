From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 24 Mar 2017 10:58:03 -0700
Subject: [GIT PULL 3/7] Broadcom devicetree-arm64 changes for 4.12
In-Reply-To: <20170324175807.27272-1-f.fainelli@gmail.com>
References: <20170324175807.27272-1-f.fainelli@gmail.com>
Message-ID: <20170324175807.27272-3-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.12/devicetree-arm64

for you to fetch changes up to 231b362aec8c38a35bdbb2456c42b503ad6ce620:

  arm64: dts: NS2: convert "ok" to "okay" (2017-03-15 14:54:21 -0700)

----------------------------------------------------------------
This pull request contains Broadcom ARM64-based SoCs Device Tree updates for
4.12, please pull the following:

- Rob enables the cryptographic block on Northstar 2 (SPU) by adding the proper
  Device Tree nodes

- Jon replaces all occurences of: status = "ok" with status = "okay" to better
  conform to the Device Tree specification

----------------------------------------------------------------
Jon Mason (1):
      arm64: dts: NS2: convert "ok" to "okay"

Rob Rice (1):
      arm64: dts: NS2: Add Broadcom SPU driver DT entry

 arch/arm64/boot/dts/broadcom/ns2-svk.dts | 38 ++++++++++++++++----------------
 arch/arm64/boot/dts/broadcom/ns2-xmc.dts | 20 ++++++++---------
 arch/arm64/boot/dts/broadcom/ns2.dtsi    | 24 ++++++++++++++++++++
 3 files changed, 53 insertions(+), 29 deletions(-)
