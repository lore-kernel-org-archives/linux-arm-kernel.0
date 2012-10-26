From: pawel.moll@arm.com (Pawel Moll)
Date: Fri, 26 Oct 2012 17:54:41 +0100
Subject: [GIT PULL] vexpress: soc changes for v3.8
In-Reply-To: <201210261645.00157.arnd@arndb.de>
References: <1350579917.4984.19.camel@hornet>
 <201210261645.00157.arnd@arndb.de>
Message-ID: <1351270481.9454.34.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-10-26 at 17:44 +0100, Arnd Bergmann wrote:
> On Thursday 18 October 2012, Pawel Moll wrote:
> >       ARM: vexpress: Start using new Versatile Express infrastructure
> 
> This patch introduces calls to vexpress_clk_of_init and other functions
> that don't yet exist. Can you send a fixup?

The clocking stuff should already be in the -next - Mike pulled it over
two weeks ago. In any case the branch is here:

The following changes since commit ddffeb8c4d0331609ef2581d84de4d763607bd37:

  Linux 3.7-rc1 (2012-10-14 14:41:04 -0700)

are available in the git repository at:

  git://git.linaro.org/people/pawelmoll/linux.git vexpress-clk

for you to fetch changes up to 807e45b32837875d55df775cb179d99e3e7d4322:

  clk: Common clocks implementation for Versatile Express (2012-10-26 17:51:29 +0100)

----------------------------------------------------------------
Pawel Moll (2):
      clk: Versatile Express clock generators ("osc") driver
      clk: Common clocks implementation for Versatile Express

 arch/arm/include/asm/hardware/sp810.h    |    2 ++
 drivers/clk/Kconfig                      |    8 +++++---
 drivers/clk/versatile/Makefile           |    2 ++
 drivers/clk/versatile/clk-vexpress-osc.c |  150 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/versatile/clk-vexpress.c     |  142 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 301 insertions(+), 3 deletions(-)
 create mode 100644 drivers/clk/versatile/clk-vexpress-osc.c
 create mode 100644 drivers/clk/versatile/clk-vexpress.c

Cheers!

Pawe?
