From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Thu, 16 Apr 2015 19:04:31 +0530
Subject: [GIT PULL] Mailbox changes for v4.1-rc1
Message-ID: <CABb+yY2r2jJqihH57hzCSdJWetTtPfT0HvXdOXYv5j9ntDrdpQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

The following changes since commit a6c5170d1edea97c538c81e377e56c7b5c5b7e63:

  Merge branch 'for-4.0' of git://linux-nfs.org/~bfields/linux
(2015-03-03 15:52:50 -0800)

are available in the git repository at:


  http://git.linaro.org/landing-teams/working/fujitsu/integration.git
mailbox-for-next

for you to fetch changes up to ee23d66af9219dfe2407a9b08ef9a165dbe6f994:

  mailbox: arm_mhu: add driver for ARM MHU controller (2015-03-17
11:12:01 +0530)

----------------------------------------------------------------
Ashwin Chaugule (1):
      Mailbox: Restructure and simplify PCC mailbox code

Jassi Brar (1):
      mailbox: arm_mhu: add driver for ARM MHU controller

 .../devicetree/bindings/mailbox/arm-mhu.txt        |  43 +++++
 drivers/mailbox/Kconfig                            |   9 +
 drivers/mailbox/Makefile                           |   2 +
 drivers/mailbox/arm_mhu.c                          | 195 +++++++++++++++++++++
 drivers/mailbox/pcc.c                              | 122 ++++---------
 5 files changed, 286 insertions(+), 85 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mailbox/arm-mhu.txt
 create mode 100644 drivers/mailbox/arm_mhu.c
