From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 6 Feb 2017 15:10:45 +0800
Subject: [PATCH 1/9] ARM: sun5i: A10s: Switch the EMAC pins indices
In-Reply-To: <8f51ef7e000e57e1fa861188d421ad1bfd9af86a.1486320544.git-series.maxime.ripard@free-electrons.com>
References: <cover.8519ab0b2252458a322bea5955d191e63f67100b.1486320544.git-series.maxime.ripard@free-electrons.com>
 <8f51ef7e000e57e1fa861188d421ad1bfd9af86a.1486320544.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v670Y8LTOJDPf1jzZJWuV5=3ci+u3ri8BV3AeMYVaq+15Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 6, 2017 at 2:49 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> One of the pins group for the EMAC can be used by all the SoCs of the sun5i
> family, and as such can be moved to the common DTSI.
>
> Unfortunately, this group is the second one we declare in our DT for now.
> Make it the first one so that it's more logical and consistent with the
> rest of our DTs before moving it.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
