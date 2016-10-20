From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 20 Oct 2016 23:17:53 +0800
Subject: [linux-sunxi] [PATCH v4 9/9] arm64: dts: add Pine64 support
In-Reply-To: <0ceb2e4d03b16b3c7edf1550ba4a79fbbfac925b.1476196031.git-series.maxime.ripard@free-electrons.com>
References: <cover.024e1b023e41efe548dc6a004f7a946408d5c9a2.1476196031.git-series.maxime.ripard@free-electrons.com>
 <0ceb2e4d03b16b3c7edf1550ba4a79fbbfac925b.1476196031.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v64BxfJbHBL0Lrkf3hRuRsM6KrPR2PAKQsPKa+eeLnk3SQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 11, 2016 at 10:28 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> From: Andre Przywara <andre.przywara@arm.com>
>
> The Pine64 is a cost-efficient development board based on the
> Allwinner A64 SoC.
> There are three models: the basic version with Fast Ethernet and
> 512 MB of DRAM (Pine64) and two Pine64+ versions, which both
> feature Gigabit Ethernet and additional connectors for touchscreens
> and a camera. Or as my son put it: "Those are smaller and these are
> missing." ;-)
> The two Pine64+ models just differ in the amount of DRAM
> (1GB vs. 2GB). Since U-Boot will figure out the right size for us and
> patches the DT accordingly we just need to provide one DT for the
> Pine64+.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> [Maxime: Removed the common DTSI and include directly the pine64 DTS]
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
