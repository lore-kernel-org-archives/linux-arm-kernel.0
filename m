From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 09 Mar 2015 20:43:41 +0100
Subject: [GIT PULL] ARM: mvebu: defconfig changes for v4.1
Message-ID: <54FDF7ED.8060405@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for defconfig for mvebu for v4.1

Gregory

The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:

  Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-defconfig-4.1

for you to fetch changes up to f224b572dcc86017d793c047c92c8479f5a6ae14:

  ARM: mvebu: enable Armada 39x in mvebu_v7_defconfig (2015-03-04 15:44:29 +0100)

----------------------------------------------------------------
mvebu defconfig changes for v4.1 (part #1)

- add the new Armada 39x SoC in mvebu_v7_defconfig

----------------------------------------------------------------
Thomas Petazzoni (1):
      ARM: mvebu: enable Armada 39x in mvebu_v7_defconfig

 arch/arm/configs/mvebu_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)
-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
