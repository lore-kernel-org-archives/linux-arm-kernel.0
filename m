From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Fri, 15 Jan 2016 21:30:53 +0530
Subject: [GIT PULL] Mailbox changes for v4.5
Message-ID: <CABb+yY1zPntaHgy8EB=ywvgetKDs4jXvDhcLzDDPtbbFx8RjYA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

The following change since commit 31ade3b83e1821da5fbb2f11b5b3d4ab2ec39db8:

  Linux 4.4-rc3 (2015-11-29 18:58:26 -0800)

are available in the git repository at:

  git://git.linaro.org/landing-teams/working/fujitsu/integration.git
mailbox-for-next

for you to fetch changes up to bfbcfa770b1c316396162f9354872dc00cd572fe:

  mailbox: constify mbox_chan_ops structure (2015-11-30 21:12:05 +0530)

----------------------------------------------------------------
Julia Lawall (1):
      mailbox: constify mbox_chan_ops structure

 drivers/mailbox/mailbox-sti.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
