From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Mon, 29 Oct 2018 11:41:29 +0530
Subject: [GIT PULL] Mailbox changes for v4.20
Message-ID: <CABb+yY3twDWnmzVGitUAXSYdkbZu0EegNRYxOXTaeQFR5QEz4g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit e704966c45e48d0220d1ee5e463034ae493a95b2:

  Merge branch 'for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input (2018-09-28
18:04:50 -0700)

are available in the Git repository at:

  git://git.linaro.org/landing-teams/working/fujitsu/integration.git
tags/mailbox-v4.20

for you to fetch changes up to 9f0a0a381c5db56e7922dbeea6831f27db58372f:

  mailbox: mediatek: Add check for possible failure of kzalloc
(2018-09-29 12:42:39 +0530)

----------------------------------------------------------------
- Convert print users to use the %pOFn format specifier
- Enable ti-msgmr driver for the K3 platform as well
- Add QCS404 to compatible list of QCOM's APCS IPC driver
- Minor spelling fixes toogle -> toggle
- kzalloc failure catch in Mediatek driver

----------------------------------------------------------------
Bjorn Andersson (1):
      mailbox: qcom: Add QCS404 APPS Global compatible

Colin Ian King (1):
      mailbox: bcm-flexrm-mailbox: fix spelling mistake "toogle" -> "toggle"

Houlong Wei (1):
      mailbox: mediatek: Add check for possible failure of kzalloc

Nishanth Menon (1):
      drivers: mailbox: Make ti-msgmr driver depend on ARCH_K3

Rob Herring (1):
      mailbox: Convert to using %pOFn instead of device_node.name

 .../devicetree/bindings/mailbox/qcom,apcs-kpss-global.txt         | 1 +
 drivers/mailbox/Kconfig                                           | 8 ++++----
 drivers/mailbox/bcm-flexrm-mailbox.c                              | 6 +++---
 drivers/mailbox/mtk-cmdq-mailbox.c                                | 3 +++
 drivers/mailbox/qcom-apcs-ipc-mailbox.c                           | 1 +
 drivers/mailbox/ti-msgmgr.c                                       | 4 ++--
 6 files changed, 14 insertions(+), 9 deletions(-)
