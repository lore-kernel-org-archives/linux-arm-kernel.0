From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 17 Oct 2017 18:00:10 +0800
Subject: [PATCH 07/23] drm/sun4i: tcon: Move out the tcon0 common setup
In-Reply-To: <03df3b0c8a1823b39a2ae0b190722f3623e76894.1508231063.git-series.maxime.ripard@free-electrons.com>
References: <cover.fe3d65d1ee05a55224d26e7d113388c428592b26.1508231063.git-series.maxime.ripard@free-electrons.com>
 <03df3b0c8a1823b39a2ae0b190722f3623e76894.1508231063.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v65QoGN02e6qrZa+-5aGrnkhy+hrE_1GmbiEFdvOVY49dA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 17, 2017 at 5:06 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Some channel0 setup has to be done, no matter what the output interface is
> (RGB, CPU, LVDS). Move that code into a common function in order to avoid
> duplication.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
