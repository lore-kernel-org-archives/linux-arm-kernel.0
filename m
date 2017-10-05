From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 5 Oct 2017 23:22:21 +0800
Subject: [PATCH 01/20] ARM: dts: sunxi: Remove leading zeros from
 unit-addresses
In-Reply-To: <b59c0d69a9210cc9b0b537a4ccc00655db1a8e07.1507198895.git-series.maxime.ripard@free-electrons.com>
References: <cover.f5f905a5434f2a540d6844d23369a04af9f5314c.1507198895.git-series.maxime.ripard@free-electrons.com>
 <b59c0d69a9210cc9b0b537a4ccc00655db1a8e07.1507198895.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v64aN8AZbrxA_=SLNy-oySKmbE5070pf_nFaRxjNVTb4ig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 5, 2017 at 6:49 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Most of our device trees have had leading zeros for padding as part of
> the nodes unit-addresses.
>
> Remove all these useless zeros that generate warnings
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
