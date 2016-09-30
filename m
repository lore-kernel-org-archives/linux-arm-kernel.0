From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 30 Sep 2016 12:23:13 -0700
Subject: [GIT PULL 2/4] Broadcom devicetree-arm64 changes for 4.9 (part 2)
In-Reply-To: <1475263395-27653-1-git-send-email-f.fainelli@gmail.com>
References: <1475263395-27653-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1475263395-27653-2-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 5072ed1fa29fa7cef73a7fb82f696e50973e02dc:

  arm64: dts: Add PWM DT node for NS2 (2016-08-08 11:03:58 -0700)

are available in the git repository at:

  http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.9/devicetree-arm64-part2

for you to fetch changes up to 33fb674b66f2529701d0b5b5e78a446fc377a8f1:

  ARM64: dts: NS2: Add QSPI Device Tree node (2016-09-14 13:30:50 -0700)

----------------------------------------------------------------
This pull request contains Broadcom ARM64-based SoCs Device Tree changes for
4.9, please pull the following:

- Kamal adds the QSPI Device Tree node to the Northstar 2 SoC and updates the
  Northstar 2 SVK reference board DTS file with it enabled.

----------------------------------------------------------------
Kamal Dasu (1):
      ARM64: dts: NS2: Add QSPI Device Tree node

 arch/arm64/boot/dts/broadcom/ns2-svk.dts | 34 ++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/broadcom/ns2.dtsi    | 18 +++++++++++++++++
 2 files changed, 52 insertions(+)
