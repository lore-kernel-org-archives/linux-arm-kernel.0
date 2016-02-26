From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 26 Feb 2016 16:16:06 +0900
Subject: [PATCH 0/2] ARM: uniphier: UniPhier updates for Linux 4.6-rc1 (2nd
 round)
Message-ID: <1456470968-7900-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

Here is a small patch series for UniPhier SoC updates.



Masahiro Yamada (2):
  ARM: uniphier: add missing of_node_put()
  ARM: uniphier: rework SMP code to support new System Bus binding

 arch/arm/mach-uniphier/platsmp.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

-- 
1.9.1
