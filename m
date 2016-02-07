From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Sun, 7 Feb 2016 21:35:00 +0530
Subject: [GIT PULL] Mailbox fixes for -rc3
Message-ID: <CABb+yY0Da=jRU9RMW5bJ2LHgnxjVLhs6A_AvHWg=i1+6j=k8PA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

The following changes since commit 34229b277480f46c1e9a19f027f30b074512e68b:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net
(2016-02-01 15:56:08 -0800)

are available in the git repository at:


  git://git.linaro.org/landing-teams/working/fujitsu/integration.git
mailbox-devel

for you to fetch changes up to 65d3b04a814679a31fe4d5edd19d89dd5b94fd40:

  mailbox: Fix dependencies for !HAS_IOMEM archs (2016-02-02 16:47:14 +0530)

----------------------------------------------------------------

- Fix getting element from the pcc-channels array by simply indexing into it

- Prevent building mailbox-test driver for archs that don't have IOMEM

----------------------------------------------------------------
Alexey Klimov (1):
      mailbox: pcc: fix channel calculation in get_pcc_channel()

Richard Weinberger (1):
      mailbox: Fix dependencies for !HAS_IOMEM archs

 drivers/mailbox/Kconfig | 1 +
 drivers/mailbox/pcc.c   | 8 +-------
 2 files changed, 2 insertions(+), 7 deletions(-)
