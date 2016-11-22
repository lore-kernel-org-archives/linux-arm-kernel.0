From: Liviu.Dudau@foss.arm.com (Liviu Dudau)
Date: Tue, 22 Nov 2016 14:14:33 +0000
Subject: [GIT PULL] arm/hdlcd fixes for v4.9-rc7
Message-ID: <20161122141433.GA18864@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

A late issue discovered by Russell King while testing his setup on Juno.
I would be really happy if it goes into v4.9-rc7 as it fixes a reference
counting problem with the pixelclock clock, but if it is too late for that
then I guess it can go into drm-next.

The following changes since commit a25f0944ba9b1d8a6813fd6f1a86f1bd59ac25a6:

  Linux 4.9-rc5 (2016-11-13 10:32:32 -0800)

are available in the git repository at:

  git://linux-arm.org/linux-ld.git for-upstream/hdlcd

for you to fetch changes up to 7a79279e7186c4ac8b753cbd335ecc4ba81b5970:

  drm/arm: hdlcd: fix plane base address update (2016-11-22 14:09:06 +0000)

----------------------------------------------------------------
Russell King (1):
      drm/arm: hdlcd: fix plane base address update

 drivers/gpu/drm/arm/hdlcd_crtc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)


Many thanks,
Liviu
-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
