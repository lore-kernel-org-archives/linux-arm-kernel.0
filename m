From: eric@anholt.net (Eric Anholt)
Date: Mon, 28 Dec 2015 21:01:22 -0800
Subject: [GIT PULL 4/4] BCM2835 defconfig changes for 4.5
In-Reply-To: <1451365282-10505-1-git-send-email-eric@anholt.net>
References: <1451365282-10505-1-git-send-email-eric@anholt.net>
Message-ID: <1451365282-10505-5-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit f74875dc36135ebae82a8e005f4b7f52289d2c40:

  usb: dwc2: fix kernel oops during driver probe (2015-11-20 09:29:47 -0600)

are available in the git repository at:

  http://github.com/anholt/linux tags/bcm2835-defconfig-next-2015-12-28

for you to fetch changes up to b63074fccbeb81e46b2553a200de54ff3bfadd10:

  ARM: bcm2835: enable auxiliary spi driver in defconfig (2015-12-21 19:29:13 -0800)

----------------------------------------------------------------
This pull request includes the bcm2835 changes for 4.5 targeting the
arm-soc next/defconfig branch.

----------------------------------------------------------------
Martin Sperl (1):
      ARM: bcm2835: enable auxiliary spi driver in defconfig

Stefan Wahren (1):
      ARM: bcm2835: enable all bcm2835-relevant in defconfig

 arch/arm/configs/bcm2835_defconfig | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)
