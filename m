From: eric@anholt.net (Eric Anholt)
Date: Tue, 16 May 2017 15:19:31 -0700
Subject: [GIT PULL] bcm2835 DT fixes for 4.12
Message-ID: <20170516221931.31292-1-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Florian,

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  git://github.com/anholt/linux tags/bcm2835-dt-fixes-2017-05-16

for you to fetch changes up to b0804ed0cadd7e38d94d2f15cdcc0d9695818856:

  ARM: dts: bcm283x: Reserve first page for firmware (2017-05-15 15:05:29 -0700)

----------------------------------------------------------------
This pull request brings in a fix for booting on SMP Raspberry Pis,
particularly with maxcpus=1

----------------------------------------------------------------
Phil Elwell (1):
      ARM: dts: bcm283x: Reserve first page for firmware

 arch/arm/boot/dts/bcm283x.dtsi | 5 +++++
 1 file changed, 5 insertions(+)
