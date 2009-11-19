From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 19 Nov 2009 09:49:20 +0000
Subject: [PATCH] arm nomadik: Introduce plat-nomadik, MTU code
	re-organization
In-Reply-To: <1257716395.29221.10.camel@vinay-desktop>
References: <1257716395.29221.10.camel@vinay-desktop>
Message-ID: <20091119094920.GG13376@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 09, 2009 at 03:09:55AM +0530, srinidhi kasagar wrote:
> From: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
> Date: Mon, 9 Nov 2009 14:37:28 +0530
> 
> Introduce the plat-nomadik folder for ST-Ericsson
> machines including the existing nomadik 8815 architecture.
> This also moves the existing MTU (MultiTimerUnit)
> of nomadik 8815 to the proposed plat-nomadik and adds
> HAS_MTU. The patch has been re-based to 2.6.32-rc6

What's the reasoning for creating plat-nomadik?  It's not clear from
the comment above.
