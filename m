From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Wed, 16 Jul 2014 11:31:50 +0300
Subject: [PATCH 6/6] clk: tegra: Add Tegra132 ccplex clocks
In-Reply-To: <53C5908C.5000009@nvidia.com>
References: <1405437890-6468-1-git-send-email-pdeschrijver@nvidia.com>
 <1405437890-6468-7-git-send-email-pdeschrijver@nvidia.com>
 <53C5908C.5000009@nvidia.com>
Message-ID: <20140716083150.GM23218@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 15, 2014 at 10:35:24PM +0200, Rhyland Klein wrote:
> On 7/15/2014 11:24 AM, Peter De Schrijver wrote:
> > Add support for the ccplex clocks in Tegra132.
> > 
> > Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> > ---
> >  drivers/clk/tegra/Makefile |    2 ++
> >  1 files changed, 2 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/clk/tegra/Makefile b/drivers/clk/tegra/Makefile
> > index f7dfb72..4231865 100644
> > --- a/drivers/clk/tegra/Makefile
> > +++ b/drivers/clk/tegra/Makefile
> > @@ -15,3 +15,5 @@ obj-$(CONFIG_ARCH_TEGRA_2x_SOC)         += clk-tegra20.o
> >  obj-$(CONFIG_ARCH_TEGRA_3x_SOC)         += clk-tegra30.o
> >  obj-$(CONFIG_ARCH_TEGRA_114_SOC)	+= clk-tegra114.o
> >  obj-$(CONFIG_ARCH_TEGRA_124_SOC)	+= clk-tegra124.o
> > +obj-$(CONFIG_ARCH_TEGRA_132_SOC)	+= clk-tegra124.c
> > +obj-$(CONFIG_ARCH_TEGRA_132_SOC)	+= clk-tegra132-ccplex.c
> > 
> 
> This doesn't seem to actually add the clk-tegra132-ccplex.c file.
> 

Indeed... how did that happen...
