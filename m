From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 17 Oct 2017 18:15:20 +0800
Subject: [PATCH 14/23] drm/sun4i: Create minimal multipliers and dividers
In-Reply-To: <1234a449a08131a74a3f4851f45458fa9b84ab5e.1508231063.git-series.maxime.ripard@free-electrons.com>
References: <cover.fe3d65d1ee05a55224d26e7d113388c428592b26.1508231063.git-series.maxime.ripard@free-electrons.com>
 <1234a449a08131a74a3f4851f45458fa9b84ab5e.1508231063.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v67i9mNh8Y+Yxw8c9Q8x_Eg=ztyBW2F+HKcAXih-RjP=tQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 17, 2017 at 5:06 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> The various outputs the TCON can provide have different constraints on the
> dotclock divider. Let's make them configurable by the various mode_set
> functions.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
