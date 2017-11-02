From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 2 Nov 2017 18:42:16 +0000
Subject: [GIT PULL] arm64 fix for 4.14
Message-ID: <20171102184215.3q7sqasz4wfkvq7v@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull the arm64 fix below. Thanks.

The following changes since commit 0b07194bb55ed836c2cc7c22e866b87a14681984:

  Linux 4.14-rc7 (2017-10-29 13:58:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to 7a7003b1da010d2b0d1dc8bf21c10f5c73b389f1:

  arm64: ensure __dump_instr() checks addr_limit (2017-11-02 18:33:08 +0000)

----------------------------------------------------------------
Check addr_limit in arm64 __dump_instr()

----------------------------------------------------------------
Mark Rutland (1):
      arm64: ensure __dump_instr() checks addr_limit

 arch/arm64/kernel/traps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
Catalin
