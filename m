From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Mon, 15 Dec 2014 10:16:25 +0200
Subject: [GIT PULL] rpmsg for 3.19
In-Reply-To: <CAK=WgbZJX1GxB-nDwYtS3Qw-TY32QBkywsCaajnCqPXhZ=HQCg@mail.gmail.com>
References: <CAK=WgbZJX1GxB-nDwYtS3Qw-TY32QBkywsCaajnCqPXhZ=HQCg@mail.gmail.com>
Message-ID: <CAK=Wgbbq5zCjuii2SQoB-erLTT_oOQAfmVe9CNuDuDB4=CkPmg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Resending in plain text mode - sorry]

The following changes since commit 5d01410fe4d92081f349b013a2e7a95429e4f2c9:

  Linux 3.18-rc6 (2014-11-23 15:25:20 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ohad/rpmsg.git
tags/rpmsg-3.19-next

for you to fetch changes up to b1b9891441fa33fd0d49b5cb3aa7f04bca1cc1db:

  rpmsg: use less buffers when vrings are small (2014-11-26 18:24:36 +0200)

----------------------------------------------------------------
A single patch from Suman Anna which makes rpmsg
use less buffers when small vrings are being used.

----------------------------------------------------------------
Suman Anna (1):
      rpmsg: use less buffers when vrings are small

 drivers/rpmsg/virtio_rpmsg_bus.c | 44 +++++++++++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 14 deletions(-)
