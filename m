From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 27 Nov 2015 10:56:05 +0900
Subject: [GIT PULL] Renesas ARM Based SoC Fixes for v4.4
Message-ID: <cover.1448586153.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC fixes for v4.4.

The single patch in this pull-request corrects a section mismatch
in r8a7793 SoC code. Thanks to Nicolas Pitre for this fix.


The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:

  Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-fixes-for-v4.4

for you to fetch changes up to c29d387b0bffb3ccce76e4fcdad9bfa7344ba338:

  ARM: shmobile: r8a7793: proper constness with __initconst (2015-11-22 17:13:13 -0800)

----------------------------------------------------------------
Renesas ARM Based SoC Fixes for v4.4

* r8a7793 SoC: Annotate r8a7793_boards_compat_dt with __initconst
  Aside from being correct this builds that otherwise
  fail with section mismatch errors.

----------------------------------------------------------------
Nicolas Pitre (1):
      ARM: shmobile: r8a7793: proper constness with __initconst

 arch/arm/mach-shmobile/setup-r8a7793.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
