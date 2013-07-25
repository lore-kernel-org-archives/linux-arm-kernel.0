From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 25 Jul 2013 13:41:32 -0400
Subject: [GIT PULL] ARM: mvebu: fixes-non-critical for v3.12
Message-ID: <20130725174132.GO23879@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The following changes since commit 3b2f64d00c46e1e4e9bd0bb9bb12619adac27a4b:

  Linux 3.11-rc2 (2013-07-21 12:05:29 -0700)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/fixes-non-3.12

for you to fetch changes up to 2746a7c272a3242f919fa2fd5a5f2d9f8a41173a:

  ARM: dove: fix missing __init section of dove_mpp_gpio_mode (2013-07-25 15:22:17 +0000)

----------------------------------------------------------------
mvebu fixes-non-critical for v3.12

 - dove
    - fix section mismatch (all callers are already _init, so it's just a space
      issue)

----------------------------------------------------------------
Sebastian Hesselbarth (1):
      ARM: dove: fix missing __init section of dove_mpp_gpio_mode

 arch/arm/mach-dove/mpp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
