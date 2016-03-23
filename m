From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Wed, 23 Mar 2016 13:46:45 +0530
Subject: [GIT PULL 2nd] Mailbox changes for v4.6
Message-ID: <CABb+yY3Y_P0+NJzvkUMEzGUSG9MiOe-K0nSSOSgAXs4oQmA94w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

 Due to some last minute cosmetic changes, the driver was not included
in the first pull request, otherwise the driver has been reviewed
twice. Could you please consider pulling it, so it doesn't get delayed
for another cycle?

The following changes since commit c5a9d1f30c066b7922a5f66b8c03a263d2f06a8c:

  mailbox: rockchip: avoid 64-bit division (2016-03-16 09:18:15 +0530)

are available in the git repository at:

  git://git.linaro.org/landing-teams/working/fujitsu/integration.git
mailbox-for-next

for you to fetch changes up to aace66b170ce7feda2d1860a81eefff37fa9d1d2:

  mailbox: Introduce TI message manager driver (2016-03-21 20:33:15 +0530)

----------------------------------------------------------------

- Device tree bindings and driver for TI's Message-Manager controller

----------------------------------------------------------------
Nishanth Menon (2):
      Documentation: dt: mailbox: Add TI Message Manager
      mailbox: Introduce TI message manager driver

 .../bindings/mailbox/ti,message-manager.txt        |  50 ++
 drivers/mailbox/Kconfig                            |  11 +
 drivers/mailbox/Makefile                           |   2 +
 drivers/mailbox/ti-msgmgr.c                        | 639 +++++++++++++++++++++
 include/linux/soc/ti/ti-msgmgr.h                   |  35 ++
 5 files changed, 737 insertions(+)
 create mode 100644
Documentation/devicetree/bindings/mailbox/ti,message-manager.txt
 create mode 100644 drivers/mailbox/ti-msgmgr.c
 create mode 100644 include/linux/soc/ti/ti-msgmgr.h
