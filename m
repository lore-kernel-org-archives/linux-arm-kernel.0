From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 13 Dec 2017 17:01:38 +0100
Subject: [PATCH 2/3] reset: meson-axg: add compatible string for
 Meson-AXG SoC
In-Reply-To: <3b61170c-c352-6b23-ab19-82c76954a911@amlogic.com>
References: <20171110084650.31325-1-yixun.lan@amlogic.com>
 <20171110084650.31325-2-yixun.lan@amlogic.com>
 <3b61170c-c352-6b23-ab19-82c76954a911@amlogic.com>
Message-ID: <1513180898.9445.3.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yixun,

On Wed, 2017-12-13 at 22:07 +0800, Yixun Lan wrote:
> Hi Philipp
> 
> On 11/10/2017 04:46 PM, Yixun Lan wrote:
> > Try to add compatible string explictly to support new Meson-AXG SoC.
> > 
> > Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> > ---
> >  drivers/reset/reset-meson.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/reset/reset-meson.c b/drivers/reset/reset-meson.c
> > index c419a3753d00..93cbee1ae8ef 100644
> > --- a/drivers/reset/reset-meson.c
> > +++ b/drivers/reset/reset-meson.c
> > @@ -139,6 +139,8 @@ static const struct of_device_id meson_reset_dt_ids[] = {
> >  	   .data = &meson_reset_meson8_ops, },
> >  	 { .compatible = "amlogic,meson-gxbb-reset",
> >  	   .data = &meson_reset_gx_ops, },
> > +	 { .compatible = "amlogic,meson-axg-reset",
> > +	   .data = &meson_reset_gx_ops, },
> >  	 { /* sentinel */ },
> >  };
> >  
> > 
> 
> it's generally a ping to the status of these two patches[1], are they
> ready to go? or do you have any comment? or do you want me to send
> another version with Neil's Reviewed-by added[1]

I forgot to update you on the status. I have put both patches on the
reset/next branch with Neil's R-b, they are in linux-next:

0e5721f76252 ("reset: meson-axg: add compatible string for Meson-AXG SoC")
c16292578ffa ("dt-bindings: reset: Add bindings for the Meson-AXG SoC Reset Controller")

I'll include them with the next pull request.

regards
Philipp
