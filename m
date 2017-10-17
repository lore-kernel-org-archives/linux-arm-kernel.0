From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 17 Oct 2017 17:22:03 +0800
Subject: [PATCH 04/23] drm/sun4i: tcon: Make tcon_get_clk_delay mode
 argument const
In-Reply-To: <e6f92f126640aa6de639386f9b4677db3d8bb37b.1508231063.git-series.maxime.ripard@free-electrons.com>
References: <cover.fe3d65d1ee05a55224d26e7d113388c428592b26.1508231063.git-series.maxime.ripard@free-electrons.com>
 <e6f92f126640aa6de639386f9b4677db3d8bb37b.1508231063.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v65BNixB8evAqk-7uRKL=OuRW2aa+4gNedz5CdXEBoFACw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 17, 2017 at 5:06 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> The drm_display_mode pointer can be mark const, so let's do it.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
