From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 17 Oct 2017 18:04:11 +0800
Subject: [PATCH 10/23] clk: sunxi-ng: Add A83T display clocks
In-Reply-To: <19afdfb5c4fea9c3b49e951cea1a184d3eec40b1.1508231063.git-series.maxime.ripard@free-electrons.com>
References: <cover.fe3d65d1ee05a55224d26e7d113388c428592b26.1508231063.git-series.maxime.ripard@free-electrons.com>
 <19afdfb5c4fea9c3b49e951cea1a184d3eec40b1.1508231063.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v65QhWGFz6R0eh0y+U_rWew0jbTprCbO7NX6OsBXb=eSfw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 17, 2017 at 5:06 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Unfortunately, the A83t display clocks are not children of the de clock,
> since that clocks doesn't exist at all on the A83t.
>
> For now, they are orphans, so let's move them to their true, existing,
> parent.
>
> Fixes: 763c5bd045b1 ("clk: sunxi-ng: add support for DE2 CCU")
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
