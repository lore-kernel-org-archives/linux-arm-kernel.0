From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 25 Aug 2014 17:18:47 +0200
Subject: [PATCH 07/14] clk: sunxi: Introduce mbus compatible
In-Reply-To: <CAGb2v64xzwySFcnhAAmPFvUOWGechLZpoxfmb0OmEGOZbV+58Q@mail.gmail.com>
References: <1405588134-2396-1-git-send-email-maxime.ripard@free-electrons.com>
 <1405588134-2396-8-git-send-email-maxime.ripard@free-electrons.com>
 <CAGb2v64xzwySFcnhAAmPFvUOWGechLZpoxfmb0OmEGOZbV+58Q@mail.gmail.com>
Message-ID: <20140825151847.GD15297@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 25, 2014 at 10:17:37PM +0800, Chen-Yu Tsai wrote:
> Hi,
> 
> On Thu, Jul 17, 2014 at 5:08 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Even though the mbus clock is a regular module clock, given its nature, it
> > needs to be enabled all the time.
> >
> > Introduce a new compatible, to differentiate it from the other module clocks.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  Documentation/devicetree/bindings/clock/sunxi.txt | 1 +
> >  drivers/clk/sunxi/clk-sunxi.c                     | 1 +
> >  2 files changed, 2 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
> > index d3a5c3c6d677..112d8525b6e0 100644
> > --- a/Documentation/devicetree/bindings/clock/sunxi.txt
> > +++ b/Documentation/devicetree/bindings/clock/sunxi.txt
> > @@ -46,6 +46,7 @@ Required properties:
> >         "allwinner,sun6i-a31-apb2-div-clk" - for the APB2 gates on A31
> >         "allwinner,sun6i-a31-apb2-gates-clk" - for the APB2 gates on A31
> >         "allwinner,sun8i-a23-apb2-gates-clk" - for the APB2 gates on A23
> > +       "allwinner,sun4i-a10-mbus-clk" - for the MBUS clock on A10
> 
> This should probably be sun5i-a13-mbus-clk?
> AFAIK the A10 doesn't have MBUS.

Ah, right, thanks!

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140825/f24c7562/attachment.sig>
