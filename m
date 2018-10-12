From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 12 Oct 2018 23:57:36 +0900
Subject: [PATCH 0/2] mmc: uniphier-sd: two bug-fixes
Message-ID: <1539356258-12374-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In further testing in uniphier-sd.c,
I found my stupid mistakes.

Ulf,

Can you squash this series into
3fd784f745dd
"mmc: uniphier-sd: add UniPhier SD/eMMC controller driver"
if you have a chance to do rebase?

Of course, it is OK to apply this series
on top of your next branch if it is too late.



Masahiro Yamada (2):
  mmc: uniphier-sd: fix DMA disabling
  mmc: uniphier-sd: avoid using broken DMA RX channel

 drivers/mmc/host/uniphier-sd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

-- 
2.7.4
