From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 28 Jan 2013 23:42:22 -0700
Subject: [GIT PULL 4/4] ARM: bcm2835: defconfig update
In-Reply-To: <1359441742-32647-1-git-send-email-swarren@wwwdotorg.org>
References: <1359441742-32647-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1359441742-32647-4-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SDHCI and I2C subsytems and drivers are enabled.

Various filesystems are enabled for use with the SDHCI driver.

Various other options expected by distros are enabled. This allows the
"Raspbian" filesystem published by the Raspberry Pi Foundation to boot
to a serial console prompt.

This branch is based on v3.8-rc3.

----------------------------------------------------------------

The following changes since commit 9931faca02c604c22335f5a935a501bb2ace6e20:

  Linux 3.8-rc3

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-rpi.git bcm2835-for-3.9-defconfig

for you to fetch changes up to d1dc7c6c6a6666fff1d40009c71965dc6600d521:

  ARM: bcm2835: defconfig updates

----------------------------------------------------------------

Stephen Warren (1):
      ARM: bcm2835: defconfig updates

 arch/arm/configs/bcm2835_defconfig |   43 ++++++++++++++++++++++++-------
 1 file changed, 33 insertions(+), 10 deletions(-)
