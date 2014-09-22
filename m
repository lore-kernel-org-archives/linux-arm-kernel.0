From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 23 Sep 2014 00:41:23 +0200
Subject: [GIT PULL] ARM: berlin: Driver changes for v3.18
Message-ID: <1411425685-27276-1-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Guys,

Berlin is a little quiet this time. Antoine is still doing a great job
but ChipIdea USB didn't make it again this time. Let's hope it makes it
next time.

At least we can add the reset driver contained in this PR.

Please pull,

The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:

  Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)

are available in the git repository at:

  git://git.infradead.org/users/hesselba/linux-berlin.git tags/berlin-driver-for-3.18-1

for you to fetch changes up to 72a3643a5f09791a95a85e1ffed6723bafe49a0e:

  reset: add the Berlin reset controller driver (2014-09-11 23:00:48 +0200)

----------------------------------------------------------------
Marvell Berlin SoCs gained a reset driver, which has been
Acked-by Philipp Zabel.

----------------------------------------------------------------
Antoine Tenart (1):
      reset: add the Berlin reset controller driver

 drivers/reset/Makefile       |   1 +
 drivers/reset/reset-berlin.c | 131 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 132 insertions(+)
 create mode 100644 drivers/reset/reset-berlin.c
