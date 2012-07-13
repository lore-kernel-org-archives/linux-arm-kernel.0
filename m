From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 13 Jul 2012 20:47:53 +0530
Subject: [GIT PULL] DaVinci DT support for v3.6
Message-ID: <50003C21.9080500@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Can you please pull the following patch adding DT support for DaVinci 
for v3.6?

Sorry for the late request, I was waiting for an ack from either Grant 
or Rob but looks like both are busy. Grant has reviewed earlier versions
of the patch.

This pull request depends on DaVinci SoC updates pulled earlier.

Thanks,
Sekhar

The following changes since commit ce9dcb8784611c50974d1c6b600c71f5c0a29308:

  ARM: davinci: add runtime PM support for clock management (2012-07-01 17:26:26 +0530)

are available in the git repository at:

  git://gitorious.org/linux-davinci/linux-davinci.git tags/davinci-v3.6-dt

for you to fetch changes up to 961e657f5a34e3f4ce2cb74cfab11f5c666b03e5:

  ARM: davinci: cp_intc: Add OF support for TI interrupt controller (2012-07-05 14:12:35 +0530)

----------------------------------------------------------------
DaVinci DT support

Add DT support for DaVinci cp_intc interrupt controller

----------------------------------------------------------------
Heiko Schocher (1):
      ARM: davinci: cp_intc: Add OF support for TI interrupt controller

 .../devicetree/bindings/arm/davinci/cp-intc.txt    |   27 ++++++++++++++++++++
 arch/arm/mach-davinci/cp_intc.c                    |   16 +++++++++---
 arch/arm/mach-davinci/include/mach/cp_intc.h       |    1 +
 3 files changed, 41 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/davinci/cp-intc.txt
