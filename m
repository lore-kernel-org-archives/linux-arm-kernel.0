From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 28 Nov 2018 20:12:54 +0800
Subject: [PATCH 45/77] ARM: dts: sun7i: som204: Use the UART3 TX and RX
 pin group
In-Reply-To: <a759b993e411da67166b0a6a86e79c6b93b7b421.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
 <a759b993e411da67166b0a6a86e79c6b93b7b421.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <CAGb2v66RGtM5x_xVtU9cHX10hehLKuBDiVGfZVZ6CutVCoJZdw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2018 at 8:47 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> The SOM204-EVB doesn't use the CTS pin, and thus was defining its own
> pinctrl node for the UART3 muxing. Since we split away the TX and RX pin,
> we can use the global node now, and only have the RTS pin in our local
> node.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
