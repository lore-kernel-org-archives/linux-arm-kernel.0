From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Sun, 4 Feb 2018 21:08:16 +0530
Subject: [GIT PULL] Mailbox changes for v4.16
Message-ID: <CABb+yY02DWB4eb9efeb3MF+hVcV3P65PiALUMd9Rde-X8t5Vxg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

The following changes since commit ef7f8cec80a0ba7bd00ece46844c8994117dc910:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net
(2018-01-08 20:21:39 -0800)

are available in the git repository at:

  git://git.linaro.org/landing-teams/working/fujitsu/integration.git
tags/mailbox-v4.16

for you to fetch changes up to 0ae7d327a64b262443b7d3ebee5831e4dde47b89:

  dt-bindings: mailbox: qcom: Document the APCS clock binding
(2018-02-04 12:16:34 +0530)

----------------------------------------------------------------
Misc driver changes only :
- TI-MsgMgr: Fix print format for a printk
- TI-MSgMgr: SPDX license switch for the driver
- QCOM-IPC: Convert driver to use regmap
- QCOM-IPC: Spawn sibling clock device from mailbox driver

----------------------------------------------------------------
Georgi Djakov (3):
      mailbox: qcom: Convert APCS IPC driver to use regmap
      mailbox: qcom: Create APCS child device for clock controller
      dt-bindings: mailbox: qcom: Document the APCS clock binding

Nishanth Menon (2):
      mailbox: ti-msgmgr: Switch to SPDX Licensing
      mailbox: ti-msgmgr: Use %zu for size_t print format

 .../bindings/mailbox/qcom,apcs-kpss-global.txt     | 18 +++++++++++
 drivers/mailbox/qcom-apcs-ipc-mailbox.c            | 35 ++++++++++++++++++----
 drivers/mailbox/ti-msgmgr.c                        | 14 ++-------
 3 files changed, 51 insertions(+), 16 deletions(-)
