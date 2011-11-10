From: jamie@jamieiles.com (Jamie Iles)
Date: Thu, 10 Nov 2011 09:56:50 +0000
Subject: [GIT PULL] picoxcell fixes for 3.2-rc
Message-ID: <20111110095649.GA16018@totoro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

I sent this to yesterday and accidentally left the list off of copy.  I 
know you've already sent a pull request to Linus, but if you could queue 
this up for the next one then that would be great!

Thanks,

Jamie

The following changes since commit 1ea6b8f48918282bdca0b32a34095504ee65bab5:

  Linux 3.2-rc1 (2011-11-07 16:16:02 -0800)

are available in the git repository at:
  git://github.com/jamieiles/linux-2.6-ji.git picoxcell-fixes

Jamie Iles (1):
      ARM: picoxcell: add extra temp register to addruart

 arch/arm/mach-picoxcell/include/mach/debug-macro.S |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)
