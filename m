From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 17 Oct 2017 17:21:09 +0800
Subject: [PATCH 03/23] drm/sun4i: tcon: Make tcon_set_mux mode argument
 const
In-Reply-To: <b0cce5a43fc3b56953d21a54fc3c14672f755f42.1508231063.git-series.maxime.ripard@free-electrons.com>
References: <cover.fe3d65d1ee05a55224d26e7d113388c428592b26.1508231063.git-series.maxime.ripard@free-electrons.com>
 <b0cce5a43fc3b56953d21a54fc3c14672f755f42.1508231063.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v65zeBsKOMnLURn7025e37=CHOFbUmi56nOoN7rGubvHrA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 17, 2017 at 5:06 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> The drm_display_mode pointer can be mark const, so let's do it.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
