From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 29 Jan 2017 12:33:32 +0800
Subject: [GIT PULL 2/2] ZTE PM domain driver support for 4.11
In-Reply-To: <1485664412-31599-1-git-send-email-shawnguo@kernel.org>
References: <1485664412-31599-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1485664412-31599-2-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 0c744ea4f77d72b3dcebb7a8f2684633ec79be88:

  Linux 4.10-rc2 (2017-01-01 14:31:53 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/zte-pd-4.11

for you to fetch changes up to 3755584a91c1cb1e50dd24a456e2953fbd276adf:

  soc: zte: pm_domains: Add support for zx296718 (2017-01-11 16:21:14 +0800)

----------------------------------------------------------------
ZTE PM domain driver support for 4.11:
 - It includes a series which adds DT bindings and PM domain driver for
   PCU (Power Control Unit) block found on ZTE ZX2967 family SoC.

----------------------------------------------------------------
Baoyou Xie (5):
      dt-bindings: zte: add bindings document for zx2967 power domain controller
      MAINTAINERS: add zx2967 SoC drivers to ARM ZTE architecture
      soc: zte: Add header for PM domains specifiers
      soc: zte: pm_domains: Prepare for supporting ARMv8 zx2967 family
      soc: zte: pm_domains: Add support for zx296718

 .../devicetree/bindings/soc/zte/pd-2967xx.txt      |  19 +++
 MAINTAINERS                                        |   4 +
 drivers/soc/Kconfig                                |   1 +
 drivers/soc/Makefile                               |   1 +
 drivers/soc/zte/Kconfig                            |  13 ++
 drivers/soc/zte/Makefile                           |   5 +
 drivers/soc/zte/zx296718_pm_domains.c              | 182 +++++++++++++++++++++
 drivers/soc/zte/zx2967_pm_domains.c                | 143 ++++++++++++++++
 drivers/soc/zte/zx2967_pm_domains.h                |  44 +++++
 include/dt-bindings/soc/zte,pm_domains.h           |  24 +++
 10 files changed, 436 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/zte/pd-2967xx.txt
 create mode 100644 drivers/soc/zte/Kconfig
 create mode 100644 drivers/soc/zte/Makefile
 create mode 100644 drivers/soc/zte/zx296718_pm_domains.c
 create mode 100644 drivers/soc/zte/zx2967_pm_domains.c
 create mode 100644 drivers/soc/zte/zx2967_pm_domains.h
 create mode 100644 include/dt-bindings/soc/zte,pm_domains.h
