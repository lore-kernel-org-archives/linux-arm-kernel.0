From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 28 Nov 2018 19:30:52 +0800
Subject: [PATCH 18/77] ARM: dts: sun5i: Fix Display Engine DTC warnings
In-Reply-To: <f2dbd10e7c99093198e133197e3cd5ad07cf7256.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
 <f2dbd10e7c99093198e133197e3cd5ad07cf7256.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <CAGb2v65ew5Nh9syqgzx+OYRJ2NJNKiNbsyutR_GDzKznpbD=bQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2018 at 8:46 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
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
