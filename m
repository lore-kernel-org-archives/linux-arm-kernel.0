From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Sun, 30 Sep 2018 20:07:14 +0200
Subject: [GIT PULL] arm: actions: drivers for v4.20 #1
In-Reply-To: <20180930180715.25829-1-afaerber@suse.de>
References: <20180930180715.25829-1-afaerber@suse.de>
Message-ID: <20180930180715.25829-4-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof and Arnd,

Here's my drivers pull for Actions Semi.

Regards,
Andreas

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-actions.git tags/actions-drivers-for-4.20

for you to fetch changes up to 067517513ae437c2845bc593dbf99a142bdc9250:

  soc: actions: Update SPS help text for S700 (2018-09-22 22:09:47 +0200)

----------------------------------------------------------------
Actions Semi SoC drivers for v4.20 #1

This adopts SPDX license identifiers.
It also updates Kconfig help text.

----------------------------------------------------------------
Andreas F?rber (2):
      soc: actions: Convert to SPDX license identifiers
      soc: actions: Update SPS help text for S700

 drivers/soc/actions/Kconfig          | 2 +-
 drivers/soc/actions/Makefile         | 2 ++
 drivers/soc/actions/owl-sps-helper.c | 6 +-----
 drivers/soc/actions/owl-sps.c        | 6 +-----
 4 files changed, 5 insertions(+), 11 deletions(-)
