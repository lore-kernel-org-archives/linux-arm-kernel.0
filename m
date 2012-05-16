From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Wed, 16 May 2012 12:36:49 +0300
Subject: [GIT PULL] remoteproc for 3.4
Message-ID: <CAK=Wgbaie_Z21md-tVHJoiA57coRu7SGSmL=GCjfh8g-No6Jhg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull a tiny but quite important remoteproc fix for 3.4.

The following changes since commit d48b97b403d23f6df0b990cee652bdf9a52337a3:

  Linux 3.4-rc6 (2012-05-06 15:07:32 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ohad/remoteproc.git
tags/rproc-for-linus

for you to fetch changes up to 6fd98c124c66b0b0001bc4217392d891b1ad4a02:

  remoteproc: fix off-by-one bug in __rproc_free_vrings (2012-05-13
23:15:42 +0300)

----------------------------------------------------------------
Fix a nasty off-by-one remoteproc bug which leaks memory when
a remote processor is shut down and, on certain circumstances,
can indirectly prevent it from being reloaded.

----------------------------------------------------------------
Subramaniam Chanderashekarapuram (1):
      remoteproc: fix off-by-one bug in __rproc_free_vrings

 drivers/remoteproc/remoteproc_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
