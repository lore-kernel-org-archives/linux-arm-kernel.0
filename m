From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 28 Nov 2018 20:49:38 +0800
Subject: [PATCH 73/77] ARM: dts: sun8i: v3s: Fix Display Engine DTC
 warnings
In-Reply-To: <90cd636016416bb35b873bccf01faeeec0346da2.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
 <90cd636016416bb35b873bccf01faeeec0346da2.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <CAGb2v66S1CJok6zS+=4kJo0-tF2sGoJb53ock-Ud=XZHD4JK1A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2018 at 8:47 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> Our display engine endpoints trigger some DTC warnings due to the fact that
> we're having a single endpoint that doesn't need any reg property, and
> since we don't have a reg property, we don't need the address-cells and
> size-cells properties anymore.
>
> Fix those
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
