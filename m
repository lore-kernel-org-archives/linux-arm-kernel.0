From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 29 Mar 2013 09:54:10 +0100
Subject: [GIT PULL] at91: tiny cleanup for 3.10 #2
Message-ID: <1364547250-19675-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

This is a one-line cleanup patch. I have made a pull-request anyway because
I do not want to mix it with my upcoming DT pull-request. I guess that you can
simply cherry-pick the patch if you want. It is based on material that you
already have in arm-soc/at91/cleanup branch.

Thanks, best regards,


The following changes since commit 9317960fa38ff50ac287904e4c751a169635ecbf:

  ARM: at91: renamme rm9200 dt file (2013-03-13 17:28:14 +0100)

are available in the git repository at:

  git://github.com/at91linux/linux-at91.git tags/at91-cleanup

for you to fetch changes up to e7619459d47a673af3433208a42f583af920e9db:

  ARM: at91: Fix typo in restart code panic message (2013-03-26 12:21:25 +0100)

----------------------------------------------------------------
Tiny one-line typo patch.

----------------------------------------------------------------
Maxime Ripard (1):
      ARM: at91: Fix typo in restart code panic message

 arch/arm/mach-at91/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
