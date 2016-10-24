From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 24 Oct 2016 10:43:25 -0700
Subject: [GIT PULL] Broadcom ARM64 Device Tree fixes for 4.9
Message-ID: <1477331005-32163-1-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.9/devicetree-arm64-fixes

for you to fetch changes up to 963d790468a2f581abf039b45edac79af5e16e55:

  arm64: dts: Updated NAND DT properties for NS2 SVK (2016-10-23 14:50:20 -0700)

----------------------------------------------------------------
This pull request contains a single fix for Broadcom ARM64-based SoCs:

- Ray adds the required bus width and OOB sector size properties to the
  Northstar 2 SVK reference board in order for the NAND controller to work
  properly

----------------------------------------------------------------
Ray Jui (1):
      arm64: dts: Updated NAND DT properties for NS2 SVK

 arch/arm64/boot/dts/broadcom/ns2-svk.dts | 2 ++
 1 file changed, 2 insertions(+)
