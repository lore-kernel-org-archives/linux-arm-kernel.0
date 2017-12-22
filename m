From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Fri, 22 Dec 2017 11:21:07 +0100
Subject: [GIT PULL] arm: actions: drivers for v4.16
In-Reply-To: <20171222102107.5661-1-afaerber@suse.de>
References: <20171222102107.5661-1-afaerber@suse.de>
Message-ID: <20171222102107.5661-3-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof and Arnd,

Here's my drivers pull for Actions Semi.
Timer changes are supposed to go via timer tree this time.

Regards,
Andreas

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>

The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-actions.git tags/actions-drivers-for-4.16

for you to fetch changes up to 3ad85b08f7789d51e6aad0f535296d1c31e319b9:

  soc: actions: sps: Add S700 (2017-11-27 23:11:01 +0100)

----------------------------------------------------------------
Actions Semi SoC drivers for v4.16

The SPS power domain driver is extended for S700 SoC.

----------------------------------------------------------------
Andreas F?rber (1):
      soc: actions: sps: Add S700

 drivers/soc/actions/owl-sps.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)
