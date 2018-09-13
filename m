From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Thu, 13 Sep 2018 07:50:32 +0200
Subject: [GIT PULL 2/3] bcm2835-dt-64-next-2018-09-09
In-Reply-To: <1536817833-3900-1-git-send-email-stefan.wahren@i2se.com>
References: <1536817833-3900-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1536817833-3900-2-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Florian,

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the git repository at:

  git://github.com/anholt/linux tags/bcm2835-dt-64-next-2018-09-09

for you to fetch changes up to a7eb26392b893bff92b1eb6483f4af3d2eb19510:

  arm64: dts: broadcom: Add reference to Compute Module IO Board V3 (2018-08-31 07:01:34 +0200)

----------------------------------------------------------------
This pull request brings in the arm64 reference for Raspberry Pi Compute
Module 3.

----------------------------------------------------------------
Stefan Wahren (1):
      arm64: dts: broadcom: Add reference to Compute Module IO Board V3

 arch/arm64/boot/dts/broadcom/Makefile                | 3 ++-
 arch/arm64/boot/dts/broadcom/bcm2837-rpi-cm3-io3.dts | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/broadcom/bcm2837-rpi-cm3-io3.dts
