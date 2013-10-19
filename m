From: tony@atomide.com (Tony Lindgren)
Date: Fri, 18 Oct 2013 17:26:32 -0700
Subject: [GIT PULL] urgent omap related x86 pinctrl build fix for v3.13 merge
 window
Message-ID: <pull-1382142392-665487>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit dc7743aa3c49fabbc6dc9edbcf7df74d776ac32e:

  pinctrl: single: Add support for auxdata (2013-10-10 15:30:47 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.13/pinctrl-fix

for you to fetch changes up to 1b9c0fb365cbb1154f4e7997061db972cbf58300:

  pinctrl: single: Fix build when not built on ARM (2013-10-18 16:43:06 -0700)

----------------------------------------------------------------
Looks like I managed to break the x86 build for some
configs. Here's a fix for that on top of the pinctrl
changes already merged with the signed tag
omap-for-v3.13/quirk-signed.

----------------------------------------------------------------
Tony Lindgren (1):
      pinctrl: single: Fix build when not built on ARM

 drivers/pinctrl/pinctrl-single.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)
