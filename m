From: pawel.moll@arm.com (Pawel Moll)
Date: Mon, 21 May 2012 09:38:44 +0100
Subject: [GIT PULL] Veratile Express DT updates for v3.5
Message-ID: <1337589524.2262.4.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Ofof,

Could you, please, pull this micro-updated for Versatile Express?
These are mostly DT changes related to A!5's architected timers and
VGIC. I have dropped the earlyprintk/uncompress patch for now because
Russell didn't like it.

Much more to come for 3.6 :-)

Thanks and apologies about short notice!

Pawel

The following changes since commit 76e10d158efb6d4516018846f60c2ab5501900bc:

  Linux 3.4 (2012-05-20 15:29:13 -0700)

are available in the git repository at:

  git://git.linaro.org/people/pawelmoll/linux.git vexpress-v3.4

for you to fetch changes up to c533f32e1ac440b8840159f89ece8c9cca2422b5:

  ARM: vexpress: Remove twice included header files (2012-05-21 09:30:42 +0100)

----------------------------------------------------------------
Pawel Moll (1):
      ARM: vexpress: Device Tree updates

Thomas Weber (1):
      ARM: vexpress: Remove twice included header files

 arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts |   13 ++++++++++++-
 arch/arm/boot/dts/vexpress-v2p-ca5s.dts     |   13 +++++++++----
 arch/arm/boot/dts/vexpress-v2p-ca9.dts      |    9 +++++++--
 arch/arm/mach-vexpress/v2m.c                |    2 --
 4 files changed, 28 insertions(+), 9 deletions(-)
