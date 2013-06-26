From: tony@atomide.com (Tony Lindgren)
Date: Wed, 26 Jun 2013 00:05:44 -0700
Subject: [GIT PULL] GPIO regression fix for omap1 for v3.10-rc
Message-ID: <20130626070543.GP5523@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 9e895ace5d82df8929b16f58e9f515f6d54ab82d:

  Linux 3.10-rc7 (2013-06-22 09:47:31 -1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.10/gpio-signed

for you to fetch changes up to 397eada946712b90e0620c378b366bcc6c98c9f6:

  gpio/omap: don't use linear domain mapping for OMAP1 (2013-06-25 23:13:40 -0700)

----------------------------------------------------------------
Fix for omap1 GPIO breaking regression.

----------------------------------------------------------------
Javier Martinez Canillas (1):
      gpio/omap: don't use linear domain mapping for OMAP1

 drivers/gpio/gpio-omap.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)
