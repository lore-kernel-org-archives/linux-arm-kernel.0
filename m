From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 28 Nov 2017 00:19:44 +0800
Subject: [PATCH v2 11/18] drm/sun4i: Add A83T support
In-Reply-To: <1c4f6b275597dec7d97b5c1d9f749ba27c0610f3.1511797218.git-series.maxime.ripard@free-electrons.com>
References: <cover.d89f3ea4e1698f9343aef4852977c80edc75f21a.1511797218.git-series.maxime.ripard@free-electrons.com>
 <1c4f6b275597dec7d97b5c1d9f749ba27c0610f3.1511797218.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v67iWKJXE8oVEgTQcamaG-UKkunCLJbZWZyM3SPSHkU7BA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 27, 2017 at 11:41 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Add support for the A83T display pipeline.
>
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 3 +++

Rob mentioned that he'd like to see these multiple one-liners be
in a separate patch.

>  drivers/gpu/drm/sun4i/sun4i_drv.c                             | 2 ++
>  drivers/gpu/drm/sun4i/sun4i_tcon.c                            | 5 +++++
>  drivers/gpu/drm/sun4i/sun8i_mixer.c                           | 4 ++++
>  4 files changed, 14 insertions(+)

Also not sure why you have two patches with the same subject.

ChenYu
