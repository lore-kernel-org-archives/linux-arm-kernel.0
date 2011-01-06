From: mkl0301@gmail.com (mkl0301 at gmail.com)
Date: Fri,  7 Jan 2011 01:53:11 +0800
Subject: [PATCH v3 0/2] add CNS3xxx AHCI support
Message-ID: <1294336393-920-1-git-send-email-mkl0301@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mac Lin <mkl0301@gmail.com>

v3:
 - Make the SoC-specific changes into ahci_platform.c directly.
 - Some cosmetic code changes

v2: http://www.spinics.net/lists/linux-ide/msg39766.html
 - Switch ahci_platform to module device table matching to add SoC specific support

v1: http://www.spinics.net/lists/arm-kernel/msg106236.html
 - Add CNS3xxx SoC specific AHCI support

This patchset is based on linux-2.6.37

Mac Lin (2):
      ahci_platform: switch to module device table matching
      ahci_platform: add support for CNS3xxx SoC devices

 arch/arm/mach-cns3xxx/devices.c |    2 +-
 drivers/ata/Kconfig             |   11 ++++++++
 drivers/ata/ahci_platform.c     |   52 ++++++++++++++++++++++++++++++++++++++-
 3 files changed, 63 insertions(+), 2 deletions(-)
