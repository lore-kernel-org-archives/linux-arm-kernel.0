From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 27 Jun 2013 00:21:20 +0530
Subject: [GIT PULL] DaVinci DT updates for v3.11
Message-ID: <51CB3828.6060407@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Can you please pull the following DT updates for v3.11?

Thanks,
Sekhar

The following changes since commit 7d132055814ef17a6c7b69f342244c410a5e000f:

  Linux 3.10-rc6 (2013-06-15 11:51:07 -1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v3.11/dt

for you to fetch changes up to 055cb2a9e065c3a606f57fbcf8de1689f7c1fedf:

  ARM: davinci: da850: adopt to pinctrl-single change for configuring multiple pins (2013-06-26 23:56:31 +0530)

----------------------------------------------------------------
Device Tree updates for DaVinci

This patch set updates da850 DTS files to enable use of
C pre-processor. Also updates pinctrl-single DT data
to go with changes done in that module to enable a
single register to service configuration of multiple
pins.

----------------------------------------------------------------
Manjunathappa, Prakash (1):
      ARM: davinci: da850: adopt to pinctrl-single change for configuring multiple pins

Philip Avinash (1):
      ARM: davinci: da850: Use #include for all device trees

 arch/arm/boot/dts/da850-enbw-cmc.dts |    2 +-
 arch/arm/boot/dts/da850-evm.dts      |    2 +-
 arch/arm/boot/dts/da850.dtsi         |    4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)
