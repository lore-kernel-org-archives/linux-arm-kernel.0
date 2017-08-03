From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 3 Aug 2017 09:13:58 +0800
Subject: [PATCH v6 0/3] ARM: dts: imx7: add NAND support
In-Reply-To: <c05aff108433c9ced4c85efcf3ba65e8@agner.ch>
References: <cover.9fab78eaa869dbad4c9ad7e8578c9cef3e49daa8.1496961128.git-series.stefan@agner.ch>
 <20170614151146.GC30112@dragon>
 <c05aff108433c9ced4c85efcf3ba65e8@agner.ch>
Message-ID: <20170803011357.GA31819@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 01, 2017 at 07:41:41PM -0700, Stefan Agner wrote:
> Hi Shawn,
> 
> On 2017-06-14 08:11, Shawn Guo wrote:
> > On Thu, Jun 08, 2017 at 03:34:46PM -0700, Stefan Agner wrote:
> >> Stefan Agner (3):
> >>   clk: imx7d: create clocks behind rawnand clock gate
> >>   ARM: dts: imx7: add GPMI NAND and APBH DMA
> >>   ARM: dts: imx7-colibri: add NAND support
> > 
> > Both dts patches look good to me.  Please ping me after the clk patch
> > lands on mainline.
> 
> The clk patch landed in mainline. These two patches seem to apply fine
> still. Can you queue them for -next?

Just applied.  Thanks for reminding.

Shawn
