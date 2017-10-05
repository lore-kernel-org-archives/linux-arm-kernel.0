From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 5 Oct 2017 23:32:52 +0800
Subject: [PATCH 06/20] ARM: dts: sun4i: Provide default muxing for
 relevant controllers
In-Reply-To: <8244ddae868d0cff052daf52e7687bd3e85f7437.1507198895.git-series.maxime.ripard@free-electrons.com>
References: <cover.f5f905a5434f2a540d6844d23369a04af9f5314c.1507198895.git-series.maxime.ripard@free-electrons.com>
 <8244ddae868d0cff052daf52e7687bd3e85f7437.1507198895.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v64pQAypz7g6vD+MnW_z9L_pqOJa9+79V6qTpPqB0EBMKw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 5, 2017 at 6:49 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Some controllers have only one muxing option in the SoC. In such a case, we
> can just move the muxing into the DTSI, and remove it from the DTS.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

It would be helpful if you could mention which controllers match the criteria.
Otherwise,

Acked-by: Chen-Yu Tsai <wens@csie.org>
