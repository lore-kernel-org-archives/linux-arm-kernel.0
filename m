From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 21 Jun 2018 21:54:50 +0200
Subject: [PATCH] ARM: dts: imx51: add CodaHx4 VPU
In-Reply-To: <20171226041517.GD4210@X250>
References: <20171213142406.5088-1-p.zabel@pengutronix.de>
 <20171226041517.GD4210@X250>
Message-ID: <1529610890.4022.7.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Tue, 2017-12-26 at 12:15 +0800, Shawn Guo wrote:
> On Wed, Dec 13, 2017 at 03:24:06PM +0100, Philipp Zabel wrote:
> > Add the CodaHx4 VPU to the i.MX51 device tree.
> > 
> > Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> > ---
> > This patch should only be applied once the patch to fix VPU register access on
> > i.MX51 [1] is merged. The coda driver with patches [2] applied will start
> > accessing VPU registers on i.MX51, which hangs the system without [1].
> 
> Ping me when it can be safely applied on IMX tree.

I forgot about this between the years, this patch is safe to be applied.

regards
Philipp
