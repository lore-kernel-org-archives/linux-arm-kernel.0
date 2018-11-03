From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sat, 3 Nov 2018 10:41:19 +0000
Subject: [GIT PULL] arm64 2nd round of updates for 4.20
Message-ID: <20181103104115.7imtevbiauvd3qls@mbp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull the arm64 updates below. Thank you.

The following changes since commit 4debef5510071032c6d5dace31ca1cc42a120073:

  arm64: KVM: Guests can skip __install_bp_hardening_cb()s HYP work (2018-10-19 15:37:25 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-upstream

for you to fetch changes up to 966866892cf89d606544bca22d584ba2ef9ec208:

  arm64: kprobe: make page to RO mode when allocate it (2018-11-02 18:15:07 +0000)

----------------------------------------------------------------
arm64 2nd round of updates for 4.20:

- Fix W+X page (mark RO) allocated by the arm64 kprobes code

- Makefile fix for .i files in out of tree modules

----------------------------------------------------------------
Anders Roxell (1):
      arm64: kprobe: make page to RO mode when allocate it

Victor Kamensky (1):
      arm64: makefile fix build of .i file in external module case

Yangtao Li (1):
      arm64: kdump: fix small typo

 arch/arm64/Makefile                |  2 ++
 arch/arm64/kernel/crash_dump.c     |  2 +-
 arch/arm64/kernel/probes/kprobes.c | 27 ++++++++++++++++++++-------
 3 files changed, 23 insertions(+), 8 deletions(-)

-- 
Catalin
