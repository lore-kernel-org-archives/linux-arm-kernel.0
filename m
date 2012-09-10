From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 10 Sep 2012 01:40:29 -0400
Subject: [GIT PULL V2] ARM: cache-l2x0 for rmk's tree
In-Reply-To: <20120829001129.GO19437@titan.lakedaemon.net>
References: <20120829001129.GO19437@titan.lakedaemon.net>
Message-ID: <20120910054029.GB15277@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Will Deacon's advice, this pull-request is intended to go through
rmk's tree.  It is a dependency for subsequent branches going through
arm-soc.  Please let me know if I've flubbed this up in any way.

thx,

Jason.

The following changes since commit 55d512e245bc7699a8800e23df1a24195dd08217:

  Linux 3.6-rc5 (2012-09-08 16:43:45 -0700)

are available in the git repository at:
  git://git.infradead.org/users/jcooper/linux.git arm/cache-l2x0

Gregory CLEMENT (2):
      arm: cache-l2x0: make outer_cache_fns a field of l2x0_of_data
      arm: cache-l2x0: add an optional register to save/restore

 arch/arm/include/asm/hardware/cache-l2x0.h |    1 +
 arch/arm/mm/cache-l2x0.c                   |   38 ++++++++++++++++++++++------
 2 files changed, 31 insertions(+), 8 deletions(-)
