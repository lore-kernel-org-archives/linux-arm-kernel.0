From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 28 Nov 2018 21:05:41 +0800
Subject: [PATCH 76/77] ARM: dts: sun9i: Fix Display Engine DTC warnings
In-Reply-To: <ea20262c67e8248f2eaf6eb6b8ec645271cf97a7.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
 <ea20262c67e8248f2eaf6eb6b8ec645271cf97a7.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <CAGb2v66qiu=QYPAU=qVcr4gGOSsz2f3f80s6wuGnJitj3TfF9g@mail.gmail.com>
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
