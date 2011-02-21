From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 21 Feb 2011 23:28:12 +0000
Subject: [patch-v2.6.39 6/7] OMAP4430: hwmod data: Adding USBOTG
In-Reply-To: <4D62ECCC.3040208@ti.com>
References: <20110217173711.GF14574@legolas.emea.dhcp.ti.com>
	<4D5D5F13.2010602@ti.com> <20110217181849.GV20795@atomide.com>
	<4D5E7DFF.7020609@ti.com>
	<20110218154135.GF11151@legolas.emea.dhcp.ti.com>
	<4D5EA36A.4000903@ti.com> <20110221182213.GD15225@atomide.com>
	<4D62DAF0.9050301@ti.com> <20110221220815.GG15225@atomide.com>
	<4D62ECCC.3040208@ti.com>
Message-ID: <20110221232812.GB15494@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 21, 2011 at 11:53:00PM +0100, Cousson, Benoit wrote:
> I still didn't fully understand the rational behind that early_init for  
> timer BTW.

To ensure that sched_clock() is setup and running before its first use.
