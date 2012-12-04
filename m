From: fabio.baltieri@linaro.org (Fabio Baltieri)
Date: Tue,  4 Dec 2012 11:10:43 +0100
Subject: [PATCH 0/2] clocksource: nomadik-mtu: support timer-based delay
Message-ID: <1354615845-2758-1-git-send-email-fabio.baltieri@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

this implements timer-based delay support for nomadik and ux500
platforms, using the MTU as time source, and marks the u8500 cpufreq
driver as CPUFREQ_CONST_LOOPS accordingly.

The patches are based on Arnd's arm-soc/ux500/mtu-clk branch, as that
contains latest MTU driver developments, including a driver move/rename,
but I can rebase if necessary.

Thanks,
Fabio


Fabio Baltieri (2):
  clocksource: nomadik-mtu: support timer-based delay
  cpufreq: db8500: set CPUFREQ_CONST_LOOPS

 drivers/clocksource/nomadik-mtu.c | 11 +++++++++++
 drivers/cpufreq/db8500-cpufreq.c  |  2 +-
 2 files changed, 12 insertions(+), 1 deletion(-)

-- 
1.7.12.1
