From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 25 Jul 2011 09:56:50 -0600
Subject: [GIT PULL] Basic arm device tree support patches for v3.1
Message-ID: <CACxGe6s8uDd_3+QyE7G5CetL0XySMZhCgg_NEn2PBRxDsGWcnA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Here are some of the basic DT patches that are needed for arm in v3.1.
 This isn't board support yet (need an ack on irq_domain first), but
it is some of the prerequisites.

g.

The following changes since commit b6844e8f64920cdee620157252169ba63afb0c89:

  Merge branch 'for-linus' of
master.kernel.org:/home/rmk/linux-2.6-arm (2011-07-24 10:20:54 -0700)

are available in the git repository at:

  git://git.secretlab.ca/git/linux-2.6 devicetree/next-arm

Grant Likely (2):
      arm/dt: Add dt machine definition
      arm/dt: Add skeleton dtsi file

Rob Herring (1):
      arm/dt: Add dtb make rule

 arch/arm/Makefile                |    7 +++++++
 arch/arm/boot/Makefile           |    6 ++++++
 arch/arm/boot/dts/skeleton.dtsi  |   13 +++++++++++++
 arch/arm/include/asm/mach/arch.h |    7 +++++++
 4 files changed, 33 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/skeleton.dtsi


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
