From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Thu, 21 Nov 2013 02:48:02 +0400
Subject: [PATCH 0/2] pcmcia: small fixes for sa1111 machine code
Message-ID: <1384987684-10692-1-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit dec8e46178bad9f1717a948572d76e0f804be801:

  Merge tag 'arc-v3.13-rc1-part2' of git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc (2013-11-19 11:44:15 -0800)

are available in the git repository at:


  git://github.com/lumag/linux sa1111-pcmcia

for you to fetch changes up to d968c6bc2fad65739e546e4adf6b72ec1f4748e7:

  pcmcia: sa1111: pass sa1111_dev to jornada720-specific code (2013-11-21 01:27:24 +0400)

----------------------------------------------------------------
Dmitry Eremin-Solenikov (2):
      pcmcia: sa1111: pass sa1111_dev to badge4-specific code
      pcmcia: sa1111: pass sa1111_dev to jornada720-specific code

 drivers/pcmcia/sa1111_badge4.c     | 2 +-
 drivers/pcmcia/sa1111_generic.c    | 4 ++--
 drivers/pcmcia/sa1111_generic.h    | 4 ++--
 drivers/pcmcia/sa1111_jornada720.c | 3 ++-
 4 files changed, 7 insertions(+), 6 deletions(-)
