From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sat, 7 Jul 2018 11:02:01 +0100
Subject: [GIT PULL] arm64 fixes for 4.18-rc4
Message-ID: <20180707100159.bs52kdpykof4wumz@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull the arm64 patches below. Thanks.

The following changes since commit 021c91791a5e7e85c567452f1be3e4c2c6cb6063:

  Linux 4.18-rc3 (2018-07-01 16:04:53 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to 1a381d4a0a9a0f999a13faaba22bf6b3fc80dcb9:

  arm64: remove no-op -p linker flag (2018-07-05 19:12:48 +0100)

----------------------------------------------------------------
arm64 LDFLAGS clean-up:

- use aarch64elf instead of aarch64linux
- move endianness options to LDFLAGS instead from LD
- remove no-op '-p' linker flag

----------------------------------------------------------------
Greg Hackmann (1):
      arm64: remove no-op -p linker flag

Masahiro Yamada (1):
      arm64: add endianness option to LDFLAGS instead of LD

Paul Kocialkowski (1):
      arm64: Use aarch64elf and aarch64elfb emulation mode variants

 arch/arm64/Makefile | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

-- 
Catalin
