From: horms@verge.net.au (Simon Horman)
Date: Thu, 30 Aug 2018 14:15:04 +0200
Subject: [PATCH 2/5] arm64: dts: renesas: r8a774a1: Add SCIF and HSCIF
 nodes
In-Reply-To: <20180824085257.uq4a34a3a6bw5w6g@verge.net.au>
References: <1535014731-64472-1-git-send-email-biju.das@bp.renesas.com>
 <1535014731-64472-3-git-send-email-biju.das@bp.renesas.com>
 <20180824085257.uq4a34a3a6bw5w6g@verge.net.au>
Message-ID: <20180830121504.52kz775f47eiosrx@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 24, 2018 at 10:52:57AM +0200, Simon Horman wrote:
> On Thu, Aug 23, 2018 at 09:58:48AM +0100, Biju Das wrote:
> > From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > 
> > Add the device nodes for all RZ/G2M SCIF and HSCIF serial ports,
> > incl. clocks, power domains and DMAs.
> > According to the HW user manual, SCIF[015] and HSCIF[012] are
> > connected to both SYS-DMAC1 and SYS-DMAC2, while SCIF[34] and
> > HSCIF[34] are connected to SYS-DMAC0.
> > 
> > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > Reviewed-by: Biju Das <biju.das@bp.renesas.com>
> 
> Thanks,
> 
> This looks fine to me but I will wait to see if there are other reviews
> before applying.

Thanks again, applied for v4.20.
