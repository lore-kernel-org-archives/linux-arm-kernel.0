From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Tue, 25 Sep 2018 12:23:58 +0200
Subject: [GIT PULL] ARM: at91: drivers for 4.20
Message-ID: <20180925102358.GA30243@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

A single trivial patch for at91 drivers.

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux tags/at91-4.20-drivers

for you to fetch changes up to f62df676d7f16580fa5085a8f51a1cbe27f7dd10:

  memory: atmel-ebi: Use struct_size() in devm_kzalloc() (2018-08-27 23:10:31 +0200)

----------------------------------------------------------------
AT91 drivers for 4.20

 - use struct_size in atmel-ebi

----------------------------------------------------------------
Gustavo A. R. Silva (1):
      memory: atmel-ebi: Use struct_size() in devm_kzalloc()

 drivers/memory/atmel-ebi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
