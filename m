From: tony@atomide.com (Tony Lindgren)
Date: Mon, 17 Jan 2011 15:21:21 -0800
Subject: [PATCH 10/14] ARM: v6k: select TLS register code according to
	V6 variants
In-Reply-To: <alpine.LFD.2.00.1101171717090.8580@xanadu.home>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
	<E1Peugh-0003St-DY@rmk-PC.arm.linux.org.uk>
	<alpine.LFD.2.00.1101171717090.8580@xanadu.home>
Message-ID: <20110117232121.GI4957@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nicolas Pitre <nico@fluxnic.net> [110117 14:22]:
> On Mon, 17 Jan 2011, Russell King - ARM Linux wrote:
> 
> > If CONFIG_CPU_V6 is enabled, we may or may not have the TLS register.
> > Use the conditional code which copes with this variability.  Otherwise,
> > if CONFIG_CPU_32v6K is set, we know we have the TLS register on all
> > supported CPUs, so use it unconditionally.
> > 
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>

Acked-by: Tony Lindgren <tony@atomide.com>
