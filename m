From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 13 Feb 2013 15:00:15 -0800
Subject: [PATCH] clk: tegra: fix driver to match DT binding
In-Reply-To: <20130213155313.GA24119@avionic-0098.mockup.avionic-design.de>
References: <1360697642-22620-1-git-send-email-swarren@wwwdotorg.org>
 <20130213155313.GA24119@avionic-0098.mockup.avionic-design.de>
Message-ID: <20130213230015.11471.46669@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Thierry Reding (2013-02-13 07:53:13)
> On Tue, Feb 12, 2013 at 12:34:02PM -0700, Stephen Warren wrote:
> > From: Stephen Warren <swarren@nvidia.com>
> > 
> > enum tegra*_clk is intended to match the IDs listed in the Tegra clock
> > bindings. There are a few mismatches, which this patch fixes:
> > 
> > 1) pll_s and cop were left out of the Tegra20 enum.
> > 
> > 2) spdif_in and spdif_out were swapped relative to the Tegra30 binding.
> > 
> > 3) i2cslow was misnamed as i2c_slow, and a duplicate i2cslow clock added
> >    to the Tegra30 enum.
> > 
> > Signed-off-by: Stephen Warren <swarren@nvidia.com>
> > ---
> >  drivers/clk/tegra/clk-tegra20.c |    4 ++--
> >  drivers/clk/tegra/clk-tegra30.c |    6 +++---
> >  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> Looks good to me and I haven't seen any regressions, so:
> 
> Reviewed-by: Thierry Reding <thierry.reding@avionic-design.de>
> Tested-by: Thierry Reding <thierry.reding@avionic-design.de>

Hurray for testing.  If this hasn't already been sent to Arnd & Olof:

Acked-by: Mike Turquette <mturquette@linaro.org>
