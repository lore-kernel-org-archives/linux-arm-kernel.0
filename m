From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 23 Jan 2013 17:15:34 +0800
Subject: [GIT PULL][for 3.9] request from pxa git tree on armsoc/board branch
Message-ID: <CAN1soZz4kgVii7hufBfgmF=yNK0YE7cOV9TNKPFe4FhRKOMpow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd & Olof,

Please help to merge armsoc/board branch from pxa git tree.

Regards
Haojian

The following changes since commit 7d1f9aeff1ee4a20b1aeb377dd0f579fe9647619:

  Linux 3.8-rc4 (2013-01-17 19:25:45 -0800)

are available in the git repository at:

  git://github.com/hzhuang1/linux.git armsoc/board

for you to fetch changes up to 495b21dc0e488b784ab1d4007d00db1ca2a95c98:

  ARM: pxa: pxa27x.c: add dummy SA1100 rtc clock (2013-01-23 17:05:08 +0800)

----------------------------------------------------------------
Andrea Adami (1):
      ARM: pxa: pxa27x.c: add dummy SA1100 rtc clock

Mike Dunn (2):
      ARM: palmtreo: add docg4 device initialization
      ARM: palmtreo: replace #if defined with IF_ENABLED

 arch/arm/mach-pxa/palmtreo.c |   35 +++++++++++++++++++++++++++++++++--
 arch/arm/mach-pxa/pxa27x.c   |    1 +
 2 files changed, 34 insertions(+), 2 deletions(-)
