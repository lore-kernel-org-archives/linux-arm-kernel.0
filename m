From: abel.vesa@nxp.com (Abel Vesa)
Date: Wed, 28 Mar 2018 06:32:18 +0000
Subject: [PATCH] clk: imx7d: Move clks_init_on before any clock operations
In-Reply-To: <CAOMZO5C23Va4Frrpqgw8LxEJbfj+cE6xeS3362QzyRn=_wi7JQ@mail.gmail.com>
References: <1522160607-7104-1-git-send-email-abel.vesa@nxp.com>
 <CAOMZO5C23Va4Frrpqgw8LxEJbfj+cE6xeS3362QzyRn=_wi7JQ@mail.gmail.com>
Message-ID: <20180328063217.nztxaphgo3uojop5@fsr-ub1664-175>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On Tue, Mar 27, 2018 at 12:08:39PM -0300, Fabio Estevam wrote:
> Hi Abel,
> 
> On Tue, Mar 27, 2018 at 11:23 AM, Abel Vesa <abel.vesa@nxp.com> wrote:
> > From: Dong Aisheng <b29396@freescale.com>
> >
> > For init on clocks we should move it at the first place in imx7d_clocks_init()
> > before any clock operations, else the clock operation may fail in case the clock
> > is still not on.
> >
> > Acked-by: Ranjani Vaidyanathan <Ranjani.Vaidyanathan@freescale.com>
> > Signed-off-by: Dong Aisheng <b29396@freescale.com>
> > Signed-off-by: Irina Tirdea <irina.tirdea@nxp.com>
> > Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> 
> Thanks for your patches.
> 
> You sent 4 patches today touching the same file.
> 
> Please annotate the sequence of the patches (1/4, 2/4, etc) so that
> the maintainer can clearly know the order the patches should be
> applied.

Yep, my bad. I'll resend as a patchset now.
-- 
