From: marex@denx.de (Marek Vasut)
Date: Tue, 26 Jun 2012 14:31:10 +0200
Subject: [PATCH 4/7] ARM: mxs: Add SPI clock into clk framwork
In-Reply-To: <20120626122424.GG8858@S2101-09.ap.freescale.net>
References: <1340477033-2761-1-git-send-email-marex@denx.de>
 <201206261416.11599.marex@denx.de>
 <20120626122424.GG8858@S2101-09.ap.freescale.net>
Message-ID: <201206261431.10782.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Shawn Guo,

> On Tue, Jun 26, 2012 at 02:16:11PM +0200, Marek Vasut wrote:
> > So why are those imx28-mmc there ? Shall these not be removed then ?
> 
> They are still needed by those non-DT board files.  Once we have those
> board files removed, these imx28-mmc lookups will not be needed any
> longer.

Ah ok, I'll discard this patch then.

Best regards,
Marek Vasut
