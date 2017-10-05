From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 5 Oct 2017 23:48:08 +0800
Subject: [PATCH 11/20] ARM: dts: sun4i: Remove all useless pinctrl nodes
In-Reply-To: <c913d459e9fa32d8907d642db55fb01d486e49a2.1507198895.git-series.maxime.ripard@free-electrons.com>
References: <cover.f5f905a5434f2a540d6844d23369a04af9f5314c.1507198895.git-series.maxime.ripard@free-electrons.com>
 <c913d459e9fa32d8907d642db55fb01d486e49a2.1507198895.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v672ZScFqkTMH3rURyVRN7knxQP8z3s+esjFV7LznzT6bw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 5, 2017 at 6:49 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> The gpio pinctrl nodes are redundant and as such useless most of the times.
> Since they will also generate warnings in DTC, we can simply remove most of
> them.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
