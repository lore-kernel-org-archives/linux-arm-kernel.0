From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 16 Oct 2013 17:35:51 +0200
Subject: pull request for tegra clocks (resend with some CCs added this
 time)
In-Reply-To: <20131015153620.GA12721@tbergstrom-lnx.Nvidia.com>
References: <20131015153620.GA12721@tbergstrom-lnx.Nvidia.com>
Message-ID: <20131016153550.GA22451@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 15, 2013 at 06:36:20PM +0300, Peter De Schrijver wrote:
> The following changes since commit a0cf1abc25ac197dd97b857c0f6341066a8cb1cf:
> 
>   Add linux-next specific files for 20130927 (2013-09-27 18:48:50 +1000)
> 
> are available in the git repository at:
>   git://nv-tegra.nvidia.com/user/pdeschrijver/linux.git tegra-clk-patches-0
> 
> Andrew Chew (1):
>       clk: tegra: Set the clk parent of host1x to pll_p
> 
> Mark Zhang (3):
>       clk: tegra: Correct sbc mux width & parent
>       clk: tegra: Fix vde/2d/3d clock src offset
>       clk: tegra: Set the clock parent of gr2d/gr3d to pll_c2
> 
> Peter De Schrijver (3):
>       ARM: tegra114: add missing clocks to binding
>       clk: tegra: replace enum tegra114_clk by binding header
>       clk: tegra: PLLE spread spectrum control
> 
> Thierry Reding (1):
>       clk: tegra114: Rename gr_2d/gr_3d to gr2d/gr3d

I think this pull request is missing the initialization of the display
controller clocks (TEGRA114_CLK_DISP1 and TEGRA114_CLK_DISP2) from
Mikko's Dalmore HDMI series.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131016/44a0baf5/attachment.sig>
