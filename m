From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 21 Oct 2016 10:48:30 +0800
Subject: [PATCH 6/6] ARM: sun5i: chip: Add optional buses
In-Reply-To: <54f17420e7532087c4c63db46a282bfc1678d39e.1476704881.git-series.maxime.ripard@free-electrons.com>
References: <cover.92d041a0a6fe40f1c8839cabb70247445eaffdfb.1476704881.git-series.maxime.ripard@free-electrons.com>
 <54f17420e7532087c4c63db46a282bfc1678d39e.1476704881.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v663dZwuXTZFTvgAUae=X0=65cMQNaFvdy5fXzq++VEMqw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 17, 2016 at 7:49 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> The I2C1 and SPI2 buses are exposed on the CHIP headers, and are not
> explicitly dedicated to anything.
>
> Add them to the DTS with the muxing already set, but keep them disabled.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>

The CHIP docs don't mention SPI2 though.
