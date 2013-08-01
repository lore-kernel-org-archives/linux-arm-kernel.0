From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 1 Aug 2013 18:52:14 +0100
Subject: [FAILURE] omap4430-sdp allnoconfig
Message-ID: <20130801175214.GA23053@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

My allnoconfig fails with this error:

arch/arm/mach-omap2/built-in.o: In function `omap4_local_timer_init':
dss-common.c:(.init.text+0x1d90): undefined reference to `twd_local_timer_register'

Might be worth looking into whatever's missing?
