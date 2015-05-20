From: hongzhou.yang@mediatek.com (Hongzhou Yang)
Date: Tue, 19 May 2015 23:05:35 -0700
Subject: [PATCH v2 08/11] mfd: mediatek: Add GPIO sub module support
 into mfd.
In-Reply-To: <20150519093426.GS22418@x1>
References: <1432015882-8646-1-git-send-email-hongzhou.yang@mediatek.com>
 <1432015882-8646-9-git-send-email-hongzhou.yang@mediatek.com>
 <20150519093426.GS22418@x1>
Message-ID: <1432101935.4007.1.camel@mussux00.eus.mediatek.inc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-05-19 at 10:34 +0100, Lee Jones wrote:
> On Mon, 18 May 2015, Hongzhou Yang wrote:
> 
> > Register pinctrl subnode into 6397 mfd cell.
> > 
> > Signed-off-by: Hongzhou Yang <hongzhou.yang@mediatek.com>
> > ---
> >  drivers/mfd/mt6397-core.c |    3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
> > index 09bc780..012c620 100644
> > --- a/drivers/mfd/mt6397-core.c
> > +++ b/drivers/mfd/mt6397-core.c
> > @@ -34,6 +34,9 @@ static const struct mfd_cell mt6397_devs[] = {
> >  	}, {
> >  		.name = "mt6397-clk",
> >  		.of_compatible = "mediatek,mt6397-clk",
> > +	}, {
> > +		.name = "mediatek-mt6397-pinctrl",
> 
> I think the "mediatek-" part should be removed, no?


Ok, I will send another patch to change it, thank you.

Yours,
Hongzhou
