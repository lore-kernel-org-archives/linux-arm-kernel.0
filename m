From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue,  6 Sep 2016 18:59:18 -0700
Subject: [GIT PULL 4/4] Broadcom devicetree-arm64 changes for 4.9
In-Reply-To: <1473213558-11782-1-git-send-email-f.fainelli@gmail.com>
References: <1473213558-11782-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1473213558-11782-4-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.9/devicetree-arm64

for you to fetch changes up to 5072ed1fa29fa7cef73a7fb82f696e50973e02dc:

  arm64: dts: Add PWM DT node for NS2 (2016-08-08 11:03:58 -0700)

----------------------------------------------------------------
This pull request contains Broadcom ARM64-based SoC Device Tree changes for
v4.9, please pull the folllowing:

- Dhanajay adds the PWM Device Tree nodes to the Northstar 2 DTS files

----------------------------------------------------------------
Yendapally Reddy Dhananjaya Reddy (1):
      arm64: dts: Add PWM DT node for NS2

 arch/arm64/boot/dts/broadcom/ns2.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)
