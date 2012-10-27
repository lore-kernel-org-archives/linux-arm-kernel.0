From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Sun, 28 Oct 2012 07:59:54 +0800
Subject: [GIT PULL][for 3.8] pull request from upload/board in arch-pxa git
 tree
Message-ID: <CAN1soZzhb361Gs9JVmhkjqqcr6FkGg9MVO_n9Tv29F==HdhwQQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd & Olof,

Please help to pull upload/board branch from arch-pxa git tree.

Best Regards
Haojian

The following changes since commit 6f0c0580b70c89094b3422ba81118c7b959c7556:

  Linux 3.7-rc2 (2012-10-20 12:11:32 -0700)

are available in the git repository at:

  git://github.com/hzhuang1/linux.git upload/board

for you to fetch changes up to f534958f092bab25eadc25dbfa01657918239b77:

  ARM: pxa: use module_platform_driver macro (2012-10-26 17:25:15 +0800)

----------------------------------------------------------------
Paul Parsons (1):
      ARM: pxa2xx: Remove EXPERIMENTAL dependency from spi-pxa2xx driver

Srinivas Kandagatla (1):
      ARM: pxa: use module_platform_driver macro

 arch/arm/mach-pxa/pxa3xx-ulpi.c |   13 +------------
 drivers/spi/Kconfig             |    2 +-
 2 files changed, 2 insertions(+), 13 deletions(-)
