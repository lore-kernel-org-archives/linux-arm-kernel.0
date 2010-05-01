From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 1 May 2010 11:14:42 +0100
Subject: [PATCH] arm/mach-msm: Add CONFIG conditional for board-trout
In-Reply-To: <201004290241.23068.PeterHuewe@gmx.de>
References: <201004290241.23068.PeterHuewe@gmx.de>
Message-ID: <20100501101442.GH12172@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 29, 2010 at 02:41:22AM +0200, Peter Huewe wrote:
> From: Peter Huewe <peterhuewe@gmx.de>
> 
> This patch adds a conditional for CONFIG_MSM_DEBUG_UART to prevent a
> build failure[1], this is done the same way as for every board in mach-msm.
> 
> References:
> [1] http://kisskb.ellerman.id.au/kisskb/buildresult/2448102/
> 
> Signed-off-by: Peter Huewe <peterhuewe@gmx.de>

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

Who's going to deal with getting this patch upstream?
