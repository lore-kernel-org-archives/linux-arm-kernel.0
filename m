From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 28 Nov 2018 20:02:25 +0800
Subject: [PATCH 42/77] ARM: dts: sun7i: Remove gpio-keys warnings
In-Reply-To: <43e29cf38c94451bbd5b043177b4c3d3e19ca5cc.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
 <43e29cf38c94451bbd5b043177b4c3d3e19ca5cc.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <CAGb2v674Zjszaam9u0LKyVPOUEr3LzDsKp6nS1CQOKsV_2jvpQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2018 at 8:46 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> Some gpio-keys definitions in our DTs were having buttons defined with a
> unit-address and that would generate a DTC warning.
>
> Change the buttons node names to remove the warnings.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
