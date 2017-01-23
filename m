From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 23 Jan 2017 16:01:06 +0800
Subject: [PATCH v4 6/8] clk: sunxi-ng: Add sun5i CCU driver
In-Reply-To: <9c11bbe550b3e4918eb70b58d1bc59bdd540c851.1485039043.git-series.maxime.ripard@free-electrons.com>
References: <cover.04f797fe015b05f19b1d69d0650680baffb27055.1485039043.git-series.maxime.ripard@free-electrons.com>
 <9c11bbe550b3e4918eb70b58d1bc59bdd540c851.1485039043.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v67GKTa6BV6nisBPmnHnx+X0mFFr6hQZ_-kYGtDVXzAJbQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 22, 2017 at 6:50 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> The Allwinner A10s, A13, R8 and NextThing GR8 are all based on the same
> silicon, and all share the same clocks.
>
> However, they're not packaged in the same way, and therefore not all the
> controllers are actually available on all these SoCs.
>
> Introduce a clock controller driver for all these SoCs with different
> compatibles to take that into account.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
