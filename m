From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Tue, 17 Jul 2012 14:10:38 +0300
Subject: [GIT PULL] rpmsg: 1-liner fix for 3.5
Message-ID: <CAK=Wgbas=HSg1b4c3=vQSns0jPe5j_NTg-rk56q_g6AzbEGysQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

The following changes since commit 84a1caf1453c3d44050bd22db958af4a7f99315c:

  Linux 3.5-rc7 (2012-07-14 15:40:28 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ohad/rpmsg.git
tags/single-rpmsg-3.5-fix

for you to fetch changes up to 9634252617441991b01dacaf4040866feecaf36f:

  rpmsg: fix dependency on initialization order (2012-07-17 13:10:38 +0300)

----------------------------------------------------------------
A single rpmsg fix for 3.5, coming from Federico Fuga, which
eliminates the dependency on arbitrary initialization orders.

----------------------------------------------------------------
Federico Fuga (1):
      rpmsg: fix dependency on initialization order

 drivers/rpmsg/virtio_rpmsg_bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
