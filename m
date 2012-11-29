From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Thu, 29 Nov 2012 10:35:01 +0200
Subject: [GIT PULL] remoteproc: a single fix for 3.7
Message-ID: <CAK=WgbZjufLpFevD2BJbceRGS4HQqK9fas=yakDDZ2uUcdrU-w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

The following changes since commit 6f0c0580b70c89094b3422ba81118c7b959c7556:

  Linux 3.7-rc2 (2012-10-20 12:11:32 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ohad/remoteproc.git
tags/rproc-3.7-fix

for you to fetch changes up to dab55bbafdb491ce2c3f2d7136e54101e948b911:

  remoteproc: fix error path of ->find_vqs (2012-11-29 10:05:09 +0200)

----------------------------------------------------------------
A single remoteproc fix for an error path issue reported by Ido Yariv.

----------------------------------------------------------------
Ohad Ben-Cohen (1):
      remoteproc: fix error path of ->find_vqs

 drivers/remoteproc/remoteproc_virtio.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)
