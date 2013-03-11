From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 11 Mar 2013 22:24:05 +0800
Subject: [GIT PULL] mxs fixes for 3.9, take 2
Message-ID: <20130311142402.GE25910@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 95381f38c0ed85be732553bf56f613ce701d411b:

  ARM: mxs: ocotp: Fix sparse warning (2013-03-04 10:07:28 +0800)

are available in the git repository at:

  git://git.linaro.org/people/shawnguo/linux-2.6.git tags/mxs-fixes-3.9-2

for you to fetch changes up to 4a38a8502b0ea4ecbe86f60e0b2416771c51888d:

  ARM: mxs: cfa10049: Fix fb initialisation function (2013-03-07 10:54:23 +0800)

----------------------------------------------------------------
The 2nd mxs fixes for 3.9:
 - Fix an error caused by incorrect conflict resolution when
   applying the patch

----------------------------------------------------------------
Maxime Ripard (1):
      ARM: mxs: cfa10049: Fix fb initialisation function

 arch/arm/mach-mxs/mach-mxs.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)
