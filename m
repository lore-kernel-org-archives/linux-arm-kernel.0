From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 12 Jul 2018 10:25:46 +0800
Subject: [PATCH 1/2] clk: imx6sll: add GPIO LPCGs
In-Reply-To: <153132682598.143105.16881098765923078751@swboyd.mtv.corp.google.com>
References: <1529649154-5724-1-git-send-email-Anson.Huang@nxp.com>
 <153091072630.143105.2849049240391576710@swboyd.mtv.corp.google.com>
 <20180711084302.GB6959@dragon>
 <153132682598.143105.16881098765923078751@swboyd.mtv.corp.google.com>
Message-ID: <20180712022544.GP6959@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 11, 2018 at 09:33:45AM -0700, Stephen Boyd wrote:
> Quoting Shawn Guo (2018-07-11 01:43:03)
> > On Fri, Jul 06, 2018 at 01:58:46PM -0700, Stephen Boyd wrote:
> > > Quoting Anson Huang (2018-06-21 23:32:33)
> > > > According to Reference Manual Rev.0, 06/2017,
> > > > there are GPIO LPCGs defined in CCM CCGRs,
> > > > add them into clock tree.
> > > > 
> > > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > > > ---
> > > 
> > > Applied to clk-next
> > 
> > Stephen,
> > 
> > If you can apply this patch to topic branch 'clk-imx-gpio-gates', I will
> > be able to pick up patch #2 for this cycle.
> 
> Can you merge in clk-imx6sll-gpio topic branch to your tree? I'm making
> topics for all patch series, so that's why this got stuck into a
> different topic branch.

Ah, okay.  I thought you apply patches directly to clk-next, and make
topic branches only for those having dependencies involved.

For future DT patches depending on clk ones, I will check clk tree and
merge corresponding topic branch to resolve dependency.

Thanks for clarifying.

Shawn
