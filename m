From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 21 Aug 2017 15:15:58 +0200
Subject: [GIT PULL] ARM: at91: drivers fixes for 4.13
Message-ID: <20170821131558.56i2o4o677y6kjzu@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

A very late pull request for a few fixes I'm carrying in my tree for a
while.
It would be great if you could send that to Linus for 4.13.

The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/at91-ab-4.13-drivers-fixes

for you to fetch changes up to 3fb3b3c4b68e33bb4acf42361b6a0db96115de35:

  memory: atmel-ebi: Fix smc cycle xlate converter (2017-07-26 22:37:54 +0200)

----------------------------------------------------------------
Driver fixes for 4.13:

 - Multiple EBI/SMC timing setting/calculation fixes

----------------------------------------------------------------
Alexander Dahl (3):
      memory: atmel-ebi: Fix smc timing return value evaluation
      memory: atmel-ebi: Allow t_DF timings of zero ns
      memory: atmel-ebi: Fix smc cycle xlate converter

 drivers/memory/atmel-ebi.c | 10 ++++++----
 drivers/mfd/atmel-smc.c    |  2 +-
 2 files changed, 7 insertions(+), 5 deletions(-)

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170821/4ea794f6/attachment.sig>
