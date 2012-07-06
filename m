From: khilman@ti.com (Kevin Hilman)
Date: Fri, 06 Jul 2012 16:38:22 -0700
Subject: [GIT PULL] gpio/omap: final fixes for v3.5
Message-ID: <87vci08npt.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Grant,

Here's a couple (hopefully) final OMAP GPIO fixes for v3.5-rc.

Thanks,

Kevin


The following changes since commit 6b16351acbd415e66ba16bf7d473ece1574cf0bc:

  Linux 3.5-rc4 (2012-06-24 12:53:04 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_3.5/fixes/gpio-3

for you to fetch changes up to 7b86cef34afceeecf57d4d07f3cfab06f8b60b13:

  gpio/omap: fix invalid context restore of gpio bank-0 (2012-07-03 09:41:39 -0700)

----------------------------------------------------------------
Grazvydas Ignotas (1):
      gpio/omap: fix irq loss while in idle with debounce on

Jon Hunter (1):
      gpio/omap: fix invalid context restore of gpio bank-0

 drivers/gpio/gpio-omap.c |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)
