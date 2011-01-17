From: tony@atomide.com (Tony Lindgren)
Date: Mon, 17 Jan 2011 15:23:18 -0800
Subject: [PATCH 11/14] ARM: v6k: use CPU domain feature if we include
	support for arch < ARMv6K
In-Reply-To: <alpine.LFD.2.00.1101171702510.8580@xanadu.home>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
	<E1Peuh2-0003Sx-5e@rmk-PC.arm.linux.org.uk>
	<alpine.LFD.2.00.1101171702510.8580@xanadu.home>
Message-ID: <20110117232318.GJ4957@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nicolas Pitre <nico@fluxnic.net> [110117 14:02]:
> On Mon, 17 Jan 2011, Russell King - ARM Linux wrote:
> 
> > Rather than turning off CPU domain switching when the build architecture
> > includes ARMv6K, thereby causing problems for ARMv6-supporting kernels,
> > turn it on when it's required to support a CPU architecture.
> > 
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>

Acked-by: Tony Lindgren <tony@atomide.com>
