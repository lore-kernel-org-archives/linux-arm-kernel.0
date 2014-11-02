From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sun,  2 Nov 2014 12:24:31 +0100
Subject: [GIT PULL 1/3] ARM: berlin: Driver changes for v3.19 (round 1)
Message-ID: <1414927473-25249-1-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Kevin, Olof,

this is Berlin driver changes for v3.19 and just contains the reset driver
that missed the v3.18 merge window.

Please pull.

Thanks,
  Sebastian

The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:

  Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)

are available in the git repository at:

  git://git.infradead.org/users/hesselba/linux-berlin.git tags/berlin-driver-3.19-1

for you to fetch changes up to bd13251f71fc86f06b344810835bc4e5e77edef7:

  reset: add the Berlin reset controller driver (2014-10-20 16:51:56 +0200)

----------------------------------------------------------------
Berlin Driver changes for v3.19 (round 1)
- Reset driver, Acked by Philipp Zabel

----------------------------------------------------------------
Antoine T?nart (1):
      reset: add the Berlin reset controller driver

 drivers/reset/Makefile       |   1 +
 drivers/reset/reset-berlin.c | 131 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 132 insertions(+)
 create mode 100644 drivers/reset/reset-berlin.c
