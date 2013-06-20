From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 20 Jun 2013 16:32:24 +0100
Subject: [GIT PULL] arm64 perf fix for 3.10
Message-ID: <20130620153212.GA8621@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Could you please pull a simple fix for arm64/perf? Thanks.

The following changes since commit 7d132055814ef17a6c7b69f342244c410a5e000f:

  Linux 3.10-rc6 (2013-06-15 11:51:07 -1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cmarinas/linux-aarch64.git tags/arm64-stable

for you to fetch changes up to abc41254181e901ef5eda2c884ca6cd88a186b6d:

  perf: arm64: Record the user-mode PC in the call chain. (2013-06-20 10:16:39 +0100)

----------------------------------------------------------------
Perf fix (user-mode PC recording).

----------------------------------------------------------------
Jed Davis (1):
      perf: arm64: Record the user-mode PC in the call chain.

 arch/arm64/kernel/perf_event.c | 1 +
 1 file changed, 1 insertion(+)

-- 
Catalin
