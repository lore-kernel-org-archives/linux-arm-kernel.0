From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 4 Jan 2018 22:51:30 +0800
Subject: [PATCH v2 12/12] ARM: dts: sun8i: a33 Enable our display frontend
In-Reply-To: <7e28da6c07bf90e9fb0afd14975d48b7d204e3a1.1513609024.git-series.maxime.ripard@free-electrons.com>
References: <cover.baf97666d4bb722f2acfdc2c98c0461e58f31b9e.1513609024.git-series.maxime.ripard@free-electrons.com>
 <7e28da6c07bf90e9fb0afd14975d48b7d204e3a1.1513609024.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v64bmBczDE48vdvLP_mVO+W6MCdak91Xx1BLVrb-pXvFWQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 18, 2017 at 10:57 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> The display frontend can be used to do hardware scaling, colorspaces
> conversion or to implement the buffer format output by the Cedar VPU.
>
> Since we're starting to have some support for it in the DRM driver, let's
> enable its DT node.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
