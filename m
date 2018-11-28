From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 28 Nov 2018 19:54:00 +0800
Subject: [PATCH 35/77] ARM: dts: sun7i: Remove skeleton and memory to
 avoid warnings
In-Reply-To: <1da5c4b912ccb84e0d1873843410c6f8d282258c.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
 <1da5c4b912ccb84e0d1873843410c6f8d282258c.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <CAGb2v65oBc5PL7m_690PPo0XM18Z3ycreRBShBdwMSe6UYOGaw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2018 at 8:46 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> Using skeleton.dtsi will create a memory node that will generate a warning
> in DTC. However, that node will be created by the bootloader, so we can
> just remove it entirely in order to remove that warning.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
