From: ben-linux@fluff.org (Ben Dooks)
Date: Fri, 22 Jan 2010 01:16:43 +0000
Subject: [PULL] Please pull bjdooks' for-linus/samsung
Message-ID: <20100122011642.GJ26562@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A fix for the HMT machine's backlight code

The following changes since commit 3ce2f76f5dfeeacd128db9e5cd6945bac0ea0b2a:
  Ben Dooks (1):
        ARM: MINI2440: Fixup __initdata usage

are available in the git repository at:

  git://git.fluff.org/bjdooks/linux.git for-linus/samsung

Peter Korsgaard (1):
      hmt: adjust for new pwm_backlight->notify prototype

 arch/arm/mach-s3c6410/mach-hmt.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
