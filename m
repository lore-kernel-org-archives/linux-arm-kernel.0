From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 1 Feb 2012 23:46:32 +0800
Subject: [GIT PULL] mxs/defconfig for 3.4
Message-ID: <20120201154628.GC2203@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Since we do not have mxs tree pulled into linux-next, I start trying to
push stuff to arm-soc as soon as they are ready, so they do not get held
on my side.  But that also means you guys will see more frequent requests
containing small pieces from me.  Hope that is okay.

Here is one patch on mxs_defconfig update for 3.4.  Please pull.

Thanks,
Shawn

The following changes since commit dcd6c92267155e70a94b3927bce681ce74b80d1f:

  Linux 3.3-rc1 (2012-01-19 15:04:48 -0800)

are available in the git repository at:
  git://git.linaro.org/people/shawnguo/linux-2.6.git mxs/defconfig

Fabio Estevam (1):
      ARM: mx28: Let audio support be built by default

 arch/arm/configs/mxs_defconfig |   20 +++++++++++++++++---
 1 files changed, 17 insertions(+), 3 deletions(-)
