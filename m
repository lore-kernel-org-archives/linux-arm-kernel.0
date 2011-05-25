From: vinod.koul@intel.com (Koul, Vinod)
Date: Wed, 25 May 2011 17:45:18 +0530
Subject: [PATCH 2/2] dmaengine: add TODO items for future work on dma
	drivers
In-Reply-To: <BANLkTikV3qT7owEuLmsGu+ORMNv77DgXSQ@mail.gmail.com>
References: <1306323570-11133-1-git-send-email-vinod.koul@intel.com>
	<1306323570-11133-3-git-send-email-vinod.koul@intel.com>
	<BANLkTikV3qT7owEuLmsGu+ORMNv77DgXSQ@mail.gmail.com>
Message-ID: <1306325718.30236.188.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-05-25 at 14:39 +0200, Per Forlin wrote:
> On 25 May 2011 13:39, Koul, Vinod <vinod.koul@intel.com> wrote:
> > From: Vinod Koul <vinod.koul@intel.com>
> >
> > Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> > ---
> >  drivers/dma/TODO |   12 ++++++++++++
> >  1 files changed, 12 insertions(+), 0 deletions(-)
> >  create mode 100644 drivers/dma/TODO
> >
> > diff --git a/drivers/dma/TODO b/drivers/dma/TODO
> > new file mode 100644
> > index 0000000..b67d184
> > --- /dev/null
> > +++ b/drivers/dma/TODO
> > @@ -0,0 +1,12 @@
> > +TODO for slave dma
> > +
> > +1. Move remaining drivers to use new slave interface
> > +2. Remove old slave pointer machansim
> > +3. Make issue_pending to start the transaction in below drivers
> > +       - mpc512x_dma
> > +       - imx-dma
> > +       - imx-sdma
> > +       - mxs-dma.c
> > +       - dw_dmac
> > +       - intel_mid_dma
> > +       - ste_dma40
> ste_dma40 already does this. At least is does so in 2.6.39. I may not
> be up to date of what is merged for 2.6.40.
Yes, I was supposed to drop this, but forgot before sending.
I will update this before I apply if no other updates are required


-- 
~Vinod
