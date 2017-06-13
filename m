From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 13 Jun 2017 13:10:42 -0700
Subject: [GIT PULL 5/7] Broadcom defconfig changes for 4.13 (v2)
In-Reply-To: <20170613201044.9808-1-f.fainelli@gmail.com>
References: <20170613201044.9808-1-f.fainelli@gmail.com>
Message-ID: <20170613201044.9808-5-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.13/defconfig

for you to fetch changes up to e4269eb4bebec3e42e386ceeadcb8a581936f18c:

  Merge tag 'bcm2835-defconfig-next-2017-06-12' into defconfig/next (2017-06-13 12:36:49 -0700)

----------------------------------------------------------------
This pull request contains Broadcom ARM-based SoCs defconfig updates for 4.13,
please pull the following:

- Stefan updates the bcm2835_defconfig to include serial, Ethernet and USB
  gadget support which is needed for the Raspberry Pi Zero OTG changes

----------------------------------------------------------------
Florian Fainelli (1):
      Merge tag 'bcm2835-defconfig-next-2017-06-12' into defconfig/next

Stefan Wahren (1):
      ARM: bcm2835_defconfig: Enable serial & ethernet USB gadget support

 arch/arm/configs/bcm2835_defconfig | 8 ++++++++
 1 file changed, 8 insertions(+)
