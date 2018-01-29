From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 29 Jan 2018 09:52:26 +0800
Subject: [PATCH v2 11/19] drm/sun4i: framebuffer: Add a custom atomic_check
In-Reply-To: <67cb4ca9889e6bf29314db37127ff15eed279c53.1516617243.git-series.maxime.ripard@free-electrons.com>
References: <cover.9e7b6a702e4d90a13d08fbe3b0a319cbf4db687f.1516617243.git-series.maxime.ripard@free-electrons.com>
 <67cb4ca9889e6bf29314db37127ff15eed279c53.1516617243.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v66csSc28wUibVxkxFL347j5DdCP3Ni3CsLmg-ava06BDQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 22, 2018 at 6:35 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> In order to support normalized zpos, we need to call
> drm_atomic_normalize_zpos in our driver's drm_mode_config_funcs'
> atomic_check.
>
> Let's duplicate the definition of drm_atomic_helper_check for now.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
