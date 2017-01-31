From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 31 Jan 2017 11:49:02 +0800
Subject: [PATCH 14/14] ASoC: sunxi: simplify optional reset handling
In-Reply-To: <20170130114116.22089-14-p.zabel@pengutronix.de>
References: <20170130114116.22089-1-p.zabel@pengutronix.de>
 <20170130114116.22089-14-p.zabel@pengutronix.de>
Message-ID: <CAGb2v66nsjuhxXYp_5=9kSH0GBROeihB4pD2Wbc3OhvKJibRRg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 30, 2017 at 7:41 PM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> As of commit bb475230b8e5 ("reset: make optional functions really
> optional"), the reset framework API calls use NULL pointers to describe
> optional, non-present reset controls.
>
> This allows to return errors from devm_reset_control_get_optional and to
> call reset_control_deassert unconditionally.
>
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Marcus Cooper <codekipper@gmail.com>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Mark Brown <broonie@kernel.org>

FWIW,

Acked-by: Chen-Yu Tsai <wens@csie.org>
