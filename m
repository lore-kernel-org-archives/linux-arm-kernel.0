From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 28 Nov 2018 20:35:03 +0800
Subject: [PATCH 56/77] ARM: dts: sun8i: a23/a33: Remove leading zeros from
 unit-addresses
In-Reply-To: <ca6ee0daebdef6017b14ea568f5426785eadab25.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
 <ca6ee0daebdef6017b14ea568f5426785eadab25.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <CAGb2v67Z1-69O+CHVxjMZfX+cz1wFBkgKCeFP1nHE90QNT+Xnw@mail.gmail.com>
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
