From: tony@atomide.com (Tony Lindgren)
Date: Tue, 23 Jan 2018 09:42:05 -0800
Subject: [GIT PULL] one ti-sysc driver fix for v4.16 merge window
Message-ID: <pull-1516729268-155514@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit c5a2de97fbd2979fab291fb048084d3fddd322dd:

  bus: ti-sysc: Add parsing of module capabilities (2017-12-21 07:28:54 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.16/ti-sysc-fix-signed

for you to fetch changes up to 3267c081e037e2ed1a3af65ee46825799a7ccda5:

  bus: ti-sysc: Fix smartreflex sysc mask (2018-01-22 09:32:53 -0800)

----------------------------------------------------------------
One minor fix for ti-sysc smartreflex sysc mask that prevents idling
the smartreflex interconnect target module for device tree based
probing.

----------------------------------------------------------------
Tony Lindgren (1):
      bus: ti-sysc: Fix smartreflex sysc mask

 drivers/bus/ti-sysc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
