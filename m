From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Fri, 6 Apr 2018 17:50:20 +0530
Subject: [GIT PULL] Mailbox changes for v4.17
Message-ID: <CABb+yY0U36FAc+KdObDvE6MfJpNdLZ7gJxdBAG14ou7ECOduXw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

The following changes since commit 0aa3fdb8b3a6df3c2e3b61dbfe079db9d30e03cd:

  Merge tag 'scsi-fixes' of
git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi (2018-03-14
17:02:49 -0700)

are available in the git repository at:

  git://git.linaro.org/landing-teams/working/fujitsu/integration.git
tags/mailbox-v4.17

for you to fetch changes up to 41c0e939d70ddb6860e340e7532df8984783f867:

  mailbox: Add support for Hi3660 mailbox (2018-03-20 11:15:54 +0800)

----------------------------------------------------------------
- New Hi3660 mailbox driver
- Fix TEGRA Kconfig warning
- Broadcom: use dma_pool_zalloc instead of dma_pool_alloc+memset

----------------------------------------------------------------
Arnd Bergmann (1):
      mailbox: tegra: relax TEGRA_HSP_MBOX Kconfig dependencies

Kaihua Zhong (1):
      mailbox: Add support for Hi3660 mailbox

Leo Yan (1):
      dt-bindings: mailbox: Introduce Hi3660 controller binding

Souptick Joarder (1):
      maillbox: bcm-flexrm-mailbox: Use dma_pool_zalloc()

 .../bindings/mailbox/hisilicon,hi3660-mailbox.txt  |  51 ++++
 drivers/mailbox/Kconfig                            |  10 +-
 drivers/mailbox/Makefile                           |   2 +
 drivers/mailbox/bcm-flexrm-mailbox.c               |   3 +-
 drivers/mailbox/hi3660-mailbox.c                   | 312 +++++++++++++++++++++
 5 files changed, 375 insertions(+), 3 deletions(-)
 create mode 100644
Documentation/devicetree/bindings/mailbox/hisilicon,hi3660-mailbox.txt
 create mode 100644 drivers/mailbox/hi3660-mailbox.c
~
