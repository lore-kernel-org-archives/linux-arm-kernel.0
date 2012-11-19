From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 19 Nov 2012 12:16:26 +0100
Subject: [GIT PULL] Marvell mvebu defconfig updates for net and XOR
Message-ID: <1353323788-17474-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason,

Here are two simple patches that update mvebu_defconfig to enable by
default the networking stack, the mvneta network driver and the XOR
driver.

They are to be applied on top of the existing defconfig changes that
you have already queued for 3.8.

Thanks!

The following changes since commit 803b4905545039f97c7824bcab605e91ac20acbb:

  Merge remote-tracking branch 'jcooper/mvebu/dt' into mvneta-fixes (2012-11-19 12:08:58 +0100)

are available in the git repository at:


  git at github.com:MISL-EBU-System-SW/mainline-public.git tags/marvell-net-xor-defconfig-for-3.8

for you to fetch changes up to a3c99ab8e7a56de106c4fa9829f36584af4bf89d:

  arm: mvebu: update defconfig to include XOR driver (2012-11-19 12:10:54 +0100)

----------------------------------------------------------------
Marvell mvebu defconfig updates for 3.8

----------------------------------------------------------------
Thomas Petazzoni (2):
      arm: mvebu: update defconfig to include network driver
      arm: mvebu: update defconfig to include XOR driver

 arch/arm/configs/mvebu_defconfig |    7 +++++++
 1 file changed, 7 insertions(+)
