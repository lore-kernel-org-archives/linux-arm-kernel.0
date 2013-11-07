From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 7 Nov 2013 17:20:47 +0100
Subject: [PATCH v3 9/9] ARM: add initial support for Marvell Berlin SoCs
In-Reply-To: <527B67A1.3020803@gmail.com>
References: <1381235073-17134-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20131107134033.59bd127a@xhacker> <527B67A1.3020803@gmail.com>
Message-ID: <201311071720.47489.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 07 November 2013, Sebastian Hesselbarth wrote:
> Actually, IIRC smp_twd does not compile without SMP set, so the above
> should at least be 'HAVE_ARM_TWD if SMP'. If you shrink MULTI_V7 down
> to non-SMP cores, you can disable it and it will fail to compile.
> 

If there are UP-systems for which TWD is the best clocksource, we should
probably fix the code to allow that configuration. IIRC there were already
patches recently in this area, maybe it's already solved.

	Arnd
