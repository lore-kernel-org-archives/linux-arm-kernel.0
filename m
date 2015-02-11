From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Wed, 11 Feb 2015 15:00:12 +0800
Subject: [GIT PULL] Mailbox changes for 3.20
Message-ID: <CABb+yY2GQbYDBHMNG20XgQQAs2dbXoeZg9pKgUdShm4+SD+JmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

 The following changes since commit e36f014edff70fc02b3d3d79cead1d58f289332e:

  Linux 3.19-rc7 (2015-02-01 20:07:21 -0800)

are available in the git repository at:

  http://git.linaro.org/landing-teams/working/fujitsu/integration.git
mailbox-devel

for you to fetch changes up to f62092f6d77dfd9214ae753a24b76ba4ecd801d7:

  mailbox: Add Altera mailbox driver (2015-02-06 10:58:27 +0530)

----------------------------------------------------------------
Jassi Brar (1):
      mailbox: check for bit set before polling

Ley Foon Tan (1):
      mailbox: Add Altera mailbox driver

Wei Yongjun (1):
      Mailbox: Fix return value check in pcc_init()

 .../devicetree/bindings/mailbox/altera-mailbox.txt |  49 +++
 MAINTAINERS                                        |   6 +
 drivers/mailbox/Kconfig                            |   6 +
 drivers/mailbox/Makefile                           |   2 +
 drivers/mailbox/mailbox-altera.c                   | 388 +++++++++++++++++++++
 drivers/mailbox/mailbox.c                          |   2 +-
 drivers/mailbox/pcc.c                              |   4 +-
 7 files changed, 454 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mailbox/altera-mailbox.txt
 create mode 100644 drivers/mailbox/mailbox-altera.c
