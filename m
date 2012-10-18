From: pawel.moll@arm.com (Pawel Moll)
Date: Thu, 18 Oct 2012 18:08:45 +0100
Subject: [GIT PULL] vexpress: fixes for v3.8
Message-ID: <1350580125.4984.23.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Could you, please, pull this small Versatile Express fix for 3.8?

Thanks!

Pawel

The following changes since commit ddffeb8c4d0331609ef2581d84de4d763607bd37:

  Linux 3.7-rc1 (2012-10-14 14:41:04 -0700)

are available in the git repository at:

  git://git.linaro.org/people/pawelmoll/linux.git vexpress-fixes

for you to fetch changes up to 852663d94f0cc44199c31c0e42d4801302f41705:

  ARM: vexpress: Make the debug UART detection more specific (2012-10-18 17:56:16 +0100)

----------------------------------------------------------------
Pawel Moll (1):
      ARM: vexpress: Make the debug UART detection more specific

 arch/arm/include/debug/vexpress.S |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)
