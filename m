From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 9 Oct 2017 18:28:18 +0100
Subject: [GIT PULL] arm: vexpress: update for v4.15
Message-ID: <8c26e927-0edd-a5f6-94cc-97901c391a5a@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC Team,

Please pull !

Regards,
Sudeep

--

The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git
tags/vexpress-updates-4.15

for you to fetch changes up to e8b44f32a959d59eae79c09ef4e410cfef3f59d6:

  ARM: vexpress/spc: Delete an error message for a failed memory
allocation (2017-10-03 15:31:31 +0100)

----------------------------------------------------------------
ARMv7 Vexpress update/cleanup for v4.15

Cosmetic cleanup dropping extra debug messages for memory allocation
failures

----------------------------------------------------------------
Markus Elfring (1):
      ARM: vexpress/spc: Delete an error message for a failed memory
allocation

 arch/arm/mach-vexpress/spc.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)
