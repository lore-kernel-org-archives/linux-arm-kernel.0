From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 17 Oct 2017 18:02:55 +0800
Subject: [PATCH 09/23] drm/panel: lvds: Add support for the power-supply
 property
In-Reply-To: <6f688742088e5e873f8d392956e06e783667aa96.1508231063.git-series.maxime.ripard@free-electrons.com>
References: <cover.fe3d65d1ee05a55224d26e7d113388c428592b26.1508231063.git-series.maxime.ripard@free-electrons.com>
 <6f688742088e5e873f8d392956e06e783667aa96.1508231063.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v647zzgEri22_t-G64ynAH4yRBx3sMa+Kn7k-J7pYm6W_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 17, 2017 at 5:06 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> A significant number of panels need to power up a regulator in order to
> operate properly. Add support for the power-supply property to enable and
> disable such a regulator whenever needed.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
