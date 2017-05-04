From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 4 May 2017 11:57:42 +0800
Subject: [PATCH v2 11/20] drm/sun4i: tcon: Switch mux on only for composite
In-Reply-To: <9f97dbff6f99c108b5f4b7f144d02dde8c253ab6.1493812478.git-series.maxime.ripard@free-electrons.com>
References: <cover.d697f34bb7b0605c5e76cbc4167a64453e5e0984.1493812478.git-series.maxime.ripard@free-electrons.com>
 <9f97dbff6f99c108b5f4b7f144d02dde8c253ab6.1493812478.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v67xw6sWuKY=LZv60mrWb8jCfa4VNfirEpnK21+wEypGYA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 3, 2017 at 7:59 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Even though that mux is undocumented, it seems like it needs to be set to 1
> when using composite, and 0 when using HDMI.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
