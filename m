From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 25 Jun 2013 07:30:32 +0200
Subject: [RFC PATCH v2 09/12] clk: samsung: s3c64xx: Add aliases for DMA
 clocks
In-Reply-To: <CACRpkdZ0WZ03XsNNx_e1zNuu_Mqkh6cyi0cV3PrzD1LxD0s63g@mail.gmail.com>
References: <1371933764-24875-1-git-send-email-tomasz.figa@gmail.com>
 <1371933764-24875-10-git-send-email-tomasz.figa@gmail.com>
 <CACRpkdZ0WZ03XsNNx_e1zNuu_Mqkh6cyi0cV3PrzD1LxD0s63g@mail.gmail.com>
Message-ID: <3499507.mKk2LUsQ0r@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 25 of June 2013 00:38:17 Linus Walleij wrote:
> On Sat, Jun 22, 2013 at 10:42 PM, Tomasz Figa <tomasz.figa@gmail.com> 
wrote:
> > The new amba-pl08x driver requires another set of clock aliases, so
> > this patch adds them.
> > 
> > Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
> > ---
> > 
> >  drivers/clk/samsung/clk-s3c64xx.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/clk/samsung/clk-s3c64xx.c
> > b/drivers/clk/samsung/clk-s3c64xx.c index 253a972..9fb750c 100644
> > --- a/drivers/clk/samsung/clk-s3c64xx.c
> > +++ b/drivers/clk/samsung/clk-s3c64xx.c
> 
> This driver is not in my kernel mainline tree or linux-next,
> is it pending in some review?

Kind of. Actually it has been already reviewed and acked, but it is 
waiting on one dependency. I'm not sure anymore if I can get it merged for 
3.11. Probably not.

Still, this patch is just a proof of concept, showing what needs to be 
done to make all this work.

Best regards,
Tomasz
