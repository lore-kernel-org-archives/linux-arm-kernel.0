From: ssantosh@kernel.org (Santosh Shilimkar)
Date: Tue, 21 Jun 2016 09:52:03 -0700
Subject: [GIT PULL 3/3] ARM: Keystone pm_domain fix for 4.8
In-Reply-To: <1466527923-8689-1-git-send-email-ssantosh@kernel.org>
References: <1466527923-8689-1-git-send-email-ssantosh@kernel.org>
Message-ID: <1466527923-8689-3-git-send-email-ssantosh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit af8c34ce6ae32addda3788d54a7e340cad22516b:

  Linux 4.7-rc2 (2016-06-05 14:31:26 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/keystone_for_4.8

for you to fetch changes up to 39a5cbbc0e24586fc30af9ebfc9957c00f1c9f3b:

  ARM: keystone: fix missing keystone.h in pm_domain.c (2016-06-21 09:31:15 -0700)

----------------------------------------------------------------
ARM: Keystone fix for 4.8

	- pm_domain warning fix.

----------------------------------------------------------------
Ben Dooks (1):
      ARM: keystone: fix missing keystone.h in pm_domain.c

 arch/arm/mach-keystone/pm_domain.c | 2 ++
 1 file changed, 2 insertions(+)
