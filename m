From: dwalker@codeaurora.org (Daniel Walker)
Date: Sun, 02 May 2010 07:56:10 -0700
Subject: [PATCH] arm/mach-msm: Add CONFIG conditional for board-trout
In-Reply-To: <20100501101442.GH12172@n2100.arm.linux.org.uk>
References: <201004290241.23068.PeterHuewe@gmx.de>
	<20100501101442.GH12172@n2100.arm.linux.org.uk>
Message-ID: <1272812170.23015.1.camel@desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2010-05-01 at 11:14 +0100, Russell King - ARM Linux wrote:
> On Thu, Apr 29, 2010 at 02:41:22AM +0200, Peter Huewe wrote:
> > From: Peter Huewe <peterhuewe@gmx.de>
> > 
> > This patch adds a conditional for CONFIG_MSM_DEBUG_UART to prevent a
> > build failure[1], this is done the same way as for every board in mach-msm.
> > 
> > References:
> > [1] http://kisskb.ellerman.id.au/kisskb/buildresult/2448102/
> > 
> > Signed-off-by: Peter Huewe <peterhuewe@gmx.de>
> 
> Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> Who's going to deal with getting this patch upstream?

I am .. I have a similar patch in my next tree already.

Daniel
