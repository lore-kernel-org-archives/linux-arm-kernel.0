From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 26 Jun 2012 20:24:26 +0800
Subject: [PATCH 4/7] ARM: mxs: Add SPI clock into clk framwork
In-Reply-To: <201206261416.11599.marex@denx.de>
References: <1340477033-2761-1-git-send-email-marex@denx.de>
 <1340477033-2761-4-git-send-email-marex@denx.de>
 <20120626065428.GM2342@S2101-09.ap.freescale.net>
 <201206261416.11599.marex@denx.de>
Message-ID: <20120626122424.GG8858@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 26, 2012 at 02:16:11PM +0200, Marek Vasut wrote:
> So why are those imx28-mmc there ? Shall these not be removed then ?
> 
They are still needed by those non-DT board files.  Once we have those
board files removed, these imx28-mmc lookups will not be needed any
longer.

-- 
Regards,
Shawn
