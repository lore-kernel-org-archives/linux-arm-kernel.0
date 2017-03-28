From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 28 Mar 2017 18:17:01 +0900
Subject: [PATCH v5 0/3] clk: let clk_disable() return immediately if clk is
 NULL for last 3 clks
Message-ID: <1490692624-11931-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Andrew,

Please consider to apply this series to your tree.
This trivial series has been left over so long.

Stephen Boyd suggested to split the series per-arch,
and I did so.
But sub-architecture maintainers did not respond
in spite of my several times pings.


Please see this:
w90x900:   https://patchwork.kernel.org/patch/9338047/
mmp:       https://patchwork.kernel.org/patch/9338049/
blackfin   https://patchwork.kernel.org/patch/9338053/


Stephen mentioned Andrew could pick up this in case maintainers are silent.
http://lkml.iu.edu/hypermail/linux/kernel/1609.2/00801.html


Masahiro Yamada (3):
  ARM: mmp: let clk_disable() return immediately if clk is NULL
  ARM: w90x900: let clk_disable() return immediately if clk is NULL
  blackfin: bf609: let clk_disable() return immediately if clk is NULL

 arch/arm/mach-mmp/clock.c        | 3 +++
 arch/arm/mach-w90x900/clock.c    | 3 +++
 arch/blackfin/mach-bf609/clock.c | 3 +++
 3 files changed, 9 insertions(+)

-- 
2.7.4
