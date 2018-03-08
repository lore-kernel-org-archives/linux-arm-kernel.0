From: horms@verge.net.au (Simon Horman)
Date: Thu, 8 Mar 2018 09:43:36 +0100
Subject: [PATCH] arm64: dts: renesas: r8a7795: Add IPMMU-PV1 device node
In-Reply-To: <TY1PR06MB09925629ADC09D1DA9FE43E6D8D80@TY1PR06MB0992.apcprd06.prod.outlook.com>
References: <20180306093430.12486-1-horms+renesas@verge.net.au>
 <TY1PR06MB09925629ADC09D1DA9FE43E6D8D80@TY1PR06MB0992.apcprd06.prod.outlook.com>
Message-ID: <20180308084335.xnrr7ym6y2uaygte@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 07, 2018 at 11:55:16AM +0000, Yoshihiro Shimoda wrote:
> Hi Simon-san,
> 
> > From: Simon Horman, Sent: Tuesday, March 6, 2018 6:35 PM
> > 
> > Add r8a7795 IPMMU-PV1 and keep it disabled by default.
> > 
> > This device is not present in r8a7795 ES1.x and
> > is removed from the DT of those SoCs.
> > 
> > This corrects an omission in
> > 3b7e7848f0e8 ("arm64: dts: renesas: r8a7795: Add IPMMU device nodes")
> > 
> > This does not have any runtime effect.
> > 
> > Reported-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> Thank you for the patch!
> 
> Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Thanks, applied.
