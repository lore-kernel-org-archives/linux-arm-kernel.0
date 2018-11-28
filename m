From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 28 Nov 2018 20:42:56 +0800
Subject: [PATCH 68/77] ARM: dts: sun8i: h3: Remove leading zeros from
 unit-addresses
In-Reply-To: <10ebf7ec4edb013e85a3031e5cda6ee86796f2b7.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
 <10ebf7ec4edb013e85a3031e5cda6ee86796f2b7.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <CAGb2v66bOO5ViQP1fxzQFVtZr=dCfUa7ZpTR4EszvY8e9D0_gA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2018 at 8:47 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> Most of our device trees have had leading zeros for padding as part of
> the nodes unit-addresses.
>
> Remove all these useless zeros that generate warnings
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
