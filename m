From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 28 Sep 2018 21:38:31 +0200
Subject: [GIT PULL] pxa for v4.20
Message-ID: <87y3blza2w.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, and Olof,

This is the pxa pull request for 4.20, a simple single patch one.

Can you please consider pulling ?

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the git repository at:

  https://github.com/rjarzmik/linux.git tags/pxa-for-4.20

for you to fetch changes up to 13d70a59105581570e939888fc9c023432e14e33:

  dmaengine: pxa: make the filter function internal (2018-08-27 20:52:17 +0200)

----------------------------------------------------------------
This pxa update brings only a single patch, finishing the
dmaengine conversion.

----------------------------------------------------------------
Robert Jarzmik (1):
      dmaengine: pxa: make the filter function internal

 drivers/dma/pxa_dma.c       |  5 ++---
 include/linux/dma/pxa-dma.h | 11 -----------
 2 files changed, 2 insertions(+), 14 deletions(-)

-- 
Robert
