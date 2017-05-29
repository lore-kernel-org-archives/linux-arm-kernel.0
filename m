From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 29 May 2017 11:28:05 +0200
Subject: [GIT PULL] Reset controller fixes for v4.12
Message-ID: <1496050085.17695.30.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear arm-soc maintainers,

please merge this tag for v4.12, which adds a missing module license to
the hi6220_reset driver. Without this, the driver fails to load.

regards
Philipp

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  git://git.pengutronix.de/git/pza/linux.git tags/reset-fixes-for-4.12

for you to fetch changes up to 4497a224f759cd8350e07382307b55f870ef0df2:

  reset: hi6220: Set module license so that it can be loaded (2017-05-24 10:53:41 +0200)

----------------------------------------------------------------
Reset controller fixes for v4.12

- Set hi6220_reset driver module license to GPL v2 to fix module loading.

----------------------------------------------------------------
Jeremy Linton (1):
      reset: hi6220: Set module license so that it can be loaded

 drivers/reset/hisilicon/hi6220_reset.c | 2 ++
 1 file changed, 2 insertions(+)
