From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Thu, 6 Oct 2016 09:13:52 +0530
Subject: [GIT PULL] Mailbox changes for v4.9
Message-ID: <CABb+yY19ZdZVJeztGZAyPq=hb0XNtaVYDcy+Pbv_jkio4usKbA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

The following changes since commit d060e0f603a4156087813d221d818bb39ec91429:

  Merge tag 'for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/dledford/rdma
(2016-09-06 12:33:12 -0700)

are available in the git repository at:

  git://git.linaro.org/landing-teams/working/fujitsu/integration.git
mailbox-for-next

for you to fetch changes up to a649244de727b87d38fe46d86ef98c8d1fc49551:

  dt-bindings: mailbox: Add Amlogic Meson MHU Bindings (2016-09-07
13:07:18 +0530)

----------------------------------------------------------------
- New driver and DT bindings for MHU controller integrated
    on Amlogic Meson platform.

----------------------------------------------------------------
Neil Armstrong (2):
      mailbox: Add Platform Message-Handling-Unit variant driver
      dt-bindings: mailbox: Add Amlogic Meson MHU Bindings

 .../devicetree/bindings/mailbox/meson-mhu.txt      |  34 ++++
 drivers/mailbox/Kconfig                            |  10 +
 drivers/mailbox/Makefile                           |   2 +
 drivers/mailbox/platform_mhu.c                     | 205 +++++++++++++++++++++
 4 files changed, 251 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/meson-mhu.txt
 create mode 100644 drivers/mailbox/platform_mhu.c
