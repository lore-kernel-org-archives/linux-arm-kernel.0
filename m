From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 6 Sep 2010 10:34:24 +0100
Subject: [PATCH 0/4] Hacks to allow booting ARM SMP kernel on UP ARMv7
In-Reply-To: <1283765333.1926.2.camel@e102109-lin.cambridge.arm.com>
References: <20100817154035.GD20325@n2100.arm.linux.org.uk>
	<20100819073810.GR12184@atomide.com>
	<4C6CFBAF.6020407@canonical.com>
	<20100819095705.GU12184@atomide.com>
	<20100819102025.GA32151@n2100.arm.linux.org.uk>
	<20100820120622.GL25742@atomide.com>
	<20100830225527.GC11597@atomide.com>
	<20100902133637.GJ26319@n2100.arm.linux.org.uk>
	<20100902161659.GJ11597@atomide.com>
	<1283765333.1926.2.camel@e102109-lin.cambridge.arm.com>
Message-ID: <20100906093424.GB20903@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 06, 2010 at 10:28:53AM +0100, Catalin Marinas wrote:
> I haven't followed your patches closely but can we restrict the ARMv6
> SMP/UP support to only those cores that have TEX remapping (most of them
> probably)?

We don't support TEX remapping on ARMv6.
