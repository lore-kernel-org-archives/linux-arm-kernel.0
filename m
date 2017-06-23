From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Fri, 23 Jun 2017 19:25:52 +0200
Subject: [GIT PULL] ARM: actions: arm64 for v4.13
In-Reply-To: <20170623172556.12618-1-afaerber@suse.de>
References: <20170623172556.12618-1-afaerber@suse.de>
Message-ID: <20170623172556.12618-3-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

Here's the initial arm64 pull for Actions Semi.

Regards,
Andreas

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-actions.git tags/actions-arm64-soc-for-4.13

for you to fetch changes up to c88cc3ee1b2045ccff904f1187d62fdc3895a532:

  arm64: Prepare Actions Semi S900 (2017-06-19 03:14:48 +0200)

----------------------------------------------------------------
Actions Semi ARM64 SoC for v4.13

This adds a Kconfig symbol for DTs and drivers being added.

----------------------------------------------------------------
Andreas F?rber (1):
      arm64: Prepare Actions Semi S900

 arch/arm64/Kconfig.platforms | 6 ++++++
 1 file changed, 6 insertions(+)
