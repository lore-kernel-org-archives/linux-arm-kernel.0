From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Wed, 16 Oct 2013 18:53:36 +0300
Subject: pull request for tegra clocks (resend with some CCs added this
 time)
In-Reply-To: <20131016153550.GA22451@ulmo.nvidia.com>
References: <20131015153620.GA12721@tbergstrom-lnx.Nvidia.com>
 <20131016153550.GA22451@ulmo.nvidia.com>
Message-ID: <20131016155336.GN5643@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 16, 2013 at 05:35:51PM +0200, Thierry Reding wrote:
> * PGP Signed by an unknown key
> 
> On Tue, Oct 15, 2013 at 06:36:20PM +0300, Peter De Schrijver wrote:
> > The following changes since commit a0cf1abc25ac197dd97b857c0f6341066a8cb1cf:
> > 
> >   Add linux-next specific files for 20130927 (2013-09-27 18:48:50 +1000)
> > 
> > are available in the git repository at:
> >   git://nv-tegra.nvidia.com/user/pdeschrijver/linux.git tegra-clk-patches-0
> > 
> > Andrew Chew (1):
> >       clk: tegra: Set the clk parent of host1x to pll_p
> > 
> > Mark Zhang (3):
> >       clk: tegra: Correct sbc mux width & parent
> >       clk: tegra: Fix vde/2d/3d clock src offset
> >       clk: tegra: Set the clock parent of gr2d/gr3d to pll_c2
> > 
> > Peter De Schrijver (3):
> >       ARM: tegra114: add missing clocks to binding
> >       clk: tegra: replace enum tegra114_clk by binding header
> >       clk: tegra: PLLE spread spectrum control
> > 
> > Thierry Reding (1):
> >       clk: tegra114: Rename gr_2d/gr_3d to gr2d/gr3d
> 
> I think this pull request is missing the initialization of the display
> controller clocks (TEGRA114_CLK_DISP1 and TEGRA114_CLK_DISP2) from
> Mikko's Dalmore HDMI series.

I don't think they were part of the original request to be included?

Cheers,

Peter.
