From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 28 Nov 2018 20:30:34 +0800
Subject: [PATCH 62/77] ARM: dts: sun8i: a23/a33: Remove card detect pull-up
In-Reply-To: <7e71c2b672d2a007a6a98bfa0945da402e31c8ed.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
 <7e71c2b672d2a007a6a98bfa0945da402e31c8ed.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <CAGb2v65m_C1zyJ1m1Lvf5YSov3RKXZ3nb98KRO3oXse2z284SQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2018 at 8:47 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> Boards usually have an external pull-up on the card-detect signal, so
> there's no need to add another one.
>
> This also removes a DTC warning.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
