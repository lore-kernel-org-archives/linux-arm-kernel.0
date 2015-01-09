From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 9 Jan 2015 12:22:47 +0100
Subject: [PATCH 0/4] clk: tegra: add support for the Tegra132 CAR IP block
In-Reply-To: <20141216203813.22980.2301.stgit@chromeos-P9X79>
References: <20141216203813.22980.2301.stgit@chromeos-P9X79>
Message-ID: <20150109112246.GC16465@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 16, 2014 at 12:38:24PM -0800, Paul Walmsley wrote:
> This series follows up on Peter De Schrijver's posting of a Tegra132
> CAR series in July of this year.  It adds common clock framework
> support for the Tegra132 CAR IP block.
> 
> The patches are based on next-20141209 and have been compiled and
> boot-tested on a Tegra30 Beaver board, a Tegra114 Dalmore board, and a
> Tegra124 Jetson TK1.  They've also been tested on a Tegra132 Norrin
> FFD board, with some other patches applied since support for that
> board isn't completely upstream (but is coming shortly).
> 
> Intended for v3.20.
> 
> - Paul
> 
> ---
> 
> Paul Walmsley (2):
>       clk: tegra:  split Tegra124 clock header file
>       clk: tegra: Add support for the Tegra132 CAR IP block
> 
> Peter De Schrijver (2):
>       clk: tegra: make tegra_clocks_apply_init_table() arch_initcall
>       clk: tegra: Update binding doc for Tegra132

Peter, you've collected clock patches in a separate branch in the past
and sent off pull requests to Mike. Are you going to pick up these
patches, too?

With the comments on patch 4/4 addressed, the series:

Acked-by: Thierry Reding <treding@nvidia.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150109/e613aa9c/attachment.sig>
