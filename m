From: tony@atomide.com (Tony Lindgren)
Date: Thu, 2 Sep 2010 09:21:24 -0700
Subject: [PATCH 4/6] ARM: Do not call test_for_ipi or test_for_ltrirq on UP
	systems
In-Reply-To: <20100902161659.GJ11597@atomide.com>
References: <20100817141210.GJ12184@atomide.com>
	<20100817154035.GD20325@n2100.arm.linux.org.uk>
	<20100819073810.GR12184@atomide.com>
	<4C6CFBAF.6020407@canonical.com>
	<20100819095705.GU12184@atomide.com>
	<20100819102025.GA32151@n2100.arm.linux.org.uk>
	<20100820120622.GL25742@atomide.com>
	<20100830225527.GC11597@atomide.com>
	<20100902133637.GJ26319@n2100.arm.linux.org.uk>
	<20100902161659.GJ11597@atomide.com>
Message-ID: <20100902162124.GN11597@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

