From: rubini@unipv.it (Alessandro Rubini)
Date: Thu, 19 Nov 2009 11:08:38 +0100
Subject: [PATCH] arm nomadik: Introduce plat-nomadik, MTU code
	re-organization
In-Reply-To: <20091119094920.GG13376@n2100.arm.linux.org.uk>
References: <20091119094920.GG13376@n2100.arm.linux.org.uk>
	<1257716395.29221.10.camel@vinay-desktop>
Message-ID: <20091119100838.GA13662@mail.gnudd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> What's the reasoning for creating plat-nomadik?  It's not clear from
> the comment above.

Other upcoming ST/ST-E SoCs share logic cells with the Nomadik SoC.
For example the arch-ux500 (for the 8500 and other SoCs) posted to
this list uses the same timer unit.  I also have an RNG driver ready
to be submitted that is shared by the original Nomadik chip and these
other projects, but there will be other submitted drivers over time.

/alessandro
