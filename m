From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Mon, 8 Apr 2013 17:43:12 +0300
Subject: [GIT PULL] an hwspinlock fix for 3.9
Message-ID: <CAK=WgbZu8u=5pEq_W2FpYr_fP+zBhHc94pg4xWZ_0h75_1JE0w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit f6161aa153581da4a3867a2d1a7caf4be19b6ec9:

  Linux 3.9-rc2 (2013-03-10 16:54:19 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ohad/hwspinlock.git
tags/hwspinlock-3.9-fix

for you to fetch changes up to c10b90d85a5126d25c89cbaa50dc9fdd1c4d001a:

  hwspinlock: fix __hwspin_lock_request error path (2013-04-05 17:45:11 +0300)

----------------------------------------------------------------
An hwspinlock fix from Li Fei, taking care of a faulty error path.

----------------------------------------------------------------
Li Fei (1):
      hwspinlock: fix __hwspin_lock_request error path

 drivers/hwspinlock/hwspinlock_core.c | 2 ++
 1 file changed, 2 insertions(+)
