From: khilman@linaro.org (Kevin Hilman)
Date: Fri, 28 Jun 2013 11:17:47 -0700
Subject: [PATCH 0/2] ASoc: ac97: fix multi-platform build failures
Message-ID: <1372443469-20191-1-git-send-email-khilman@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

When building next-20130628, I noticed a few build errors for
cm_x300_defconfig that were introduced by the new multi-platform AC'97
support.

Here's a couple fixup patches, that should maybe just be folded into
the originals, assuming they're the correct fixes.  At least it things
build again for 

Kevin


Kevin Hilman (2):
  ASoC: ac97: pxa2xx: fixup multi-platform AC'97 build failures
  ASoC: ac97: fixup multi-platform AC'97 module build failure

 sound/soc/pxa/pxa2xx-ac97.c | 2 ++
 sound/soc/pxa/pxa2xx-ac97.h | 3 ---
 sound/soc/soc-core.c        | 1 +
 3 files changed, 3 insertions(+), 3 deletions(-)

-- 
1.8.3
