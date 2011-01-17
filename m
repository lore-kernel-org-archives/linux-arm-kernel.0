From: tony@atomide.com (Tony Lindgren)
Date: Mon, 17 Jan 2011 15:24:50 -0800
Subject: [PATCH 13/14] ARM: v6k: allow swp emulation again when ARMv7
	is enabled
In-Reply-To: <E1Peuhh-0003T5-2n@rmk-PC.arm.linux.org.uk>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
	<E1Peuhh-0003T5-2n@rmk-PC.arm.linux.org.uk>
Message-ID: <20110117232450.GL4957@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [110117 11:26]:
> Now that we build a v6+v6k+v7 kernel with -march=armv6k for everything,
> we don't need to disable swp emulation to work around the build problem
> with OMAP.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Glad to see this issue sorted out.

Tested-by: Tony Lindgren <tony@atomide.com>
