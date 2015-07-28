From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 28 Jul 2015 19:01:18 +0100
Subject: [GIT PULL] arm64 fix for 4.2-rc5
Message-ID: <20150728180117.GA20740@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull the arm64 fix below. Thanks.

The following changes since commit cbfe8fa6cd672011c755c3cd85c9ffd4e2d10a6f:

  Linux 4.2-rc4 (2015-07-26 12:26:21 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to f91b1feada0b6f0a4d33648155b3ded2c4e0707e:

  arm64/efi: map the entire UEFI vendor string before reading it (2015-07-27 18:00:05 +0100)

----------------------------------------------------------------
Fix buffer overflow when UTF-16 UEFI vendor string is copied from the
system table into a char array with a size of 100 bytes.

----------------------------------------------------------------
Ard Biesheuvel (1):
      arm64/efi: map the entire UEFI vendor string before reading it

 arch/arm64/kernel/efi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
Catalin
