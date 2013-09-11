From: rmallon@gmail.com (Ryan Mallon)
Date: Wed, 11 Sep 2013 10:18:17 +1000
Subject: [GIT PULL] ep93xx-fixes for 3.12
Message-ID: <522FB6C9.3030406@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof

The following changes since commit ad81f0545ef01ea651886dddac4bef6cec930092:

  Linux 3.11-rc1 (2013-07-14 15:18:27 -0700)

are available in the git repository at:

  git://github.com/RyanMallon/linux-ep93xx.git tags/ep93xx-fixes-for-3.12

for you to fetch changes up to cc3874fe56923e713427e4a3737c40746397347e:

  ARM: ep93xx: Don't use modem interface on the second UART (2013-09-03 14:15:04 +1000)

----------------------------------------------------------------
Petr ?tetiar (1):
      ARM: ep93xx: Don't use modem interface on the second UART

 arch/arm/mach-ep93xx/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
