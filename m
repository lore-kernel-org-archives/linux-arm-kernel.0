From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 28 Nov 2018 19:51:52 +0800
Subject: [PATCH 33/77] ARM: dts: sun6i: colombus: Change i2c node name to
 avoid warnings
In-Reply-To: <c89c360f86fcbc48d9e11fdb02ba2d65245a4643.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
 <c89c360f86fcbc48d9e11fdb02ba2d65245a4643.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <CAGb2v66q34OAOpxS-yC=aRXUJ9BbAnK+9OJav5W8vn-sTy8Mvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2018 at 8:46 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> Our I2C GPIO bus node name has a unit address, but no reg property, which
> generates a warning in DTC. Change the name to remove that unit address.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
