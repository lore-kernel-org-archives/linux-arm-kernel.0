From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 26 May 2014 17:01:22 +0200
Subject: [GIT PULL] Reset controller fixes for v3.15
Message-ID: <1401116482.3400.23.camel@paszta.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Arnd,

The following change since commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:

  Linux 3.15-rc1 (2014-04-13 14:18:35 -0700)

is available in the git repository at:

  git://git.pengutronix.de/git/pza/linux.git reset/fixes

for you to fetch at e3ec0a8c6eea4f22d5468f01c065caca4dd1ecca:

  reset: Add of_reset_control_get to reset.h (2014-04-14 16:47:28 +0200)

This patch fixes an erroneous revert that slipped in with commit
b424080a9e086e683ad5fdc624a7cf3c024e0c0f reset: Add optional resets and stubs
Without it, we get build failures in linux-next.

----------------------------------------------------------------
Hans de Goede (1):
      reset: Add of_reset_control_get to reset.h

 include/linux/reset.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

regards
Philipp
