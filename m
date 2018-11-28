From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 28 Nov 2018 20:12:04 +0800
Subject: [PATCH 44/77] ARM: dts: sun7i: Split the RTS and CTS pins out of
 the UART nodes
In-Reply-To: <998922bf617df5eff6c6f19b97d7778ad9668eb4.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
 <998922bf617df5eff6c6f19b97d7778ad9668eb4.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <CAGb2v66yv-62gmLTXm_2PV1BdT-SDFZdkN0ufwWzyP3p2LOpRw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2018 at 8:47 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> Some UART nodes on the A20 DTSI do not share the same pattern that we use
> everywhere else, with the RTS and CTS pins split away from the TX and RX
> pins. Make those pin groups consistent with the rest of our DT.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
