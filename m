From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 17 Oct 2017 20:16:28 +0800
Subject: [PATCH 23/23] arm: dts: sun8i: a711: Enable the LCD
In-Reply-To: <148ef066f9390f25fc7d4da4b4ea89862dfef06c.1508231063.git-series.maxime.ripard@free-electrons.com>
References: <cover.fe3d65d1ee05a55224d26e7d113388c428592b26.1508231063.git-series.maxime.ripard@free-electrons.com>
 <148ef066f9390f25fc7d4da4b4ea89862dfef06c.1508231063.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v66i9nrn7wTs+Ctu38Xiugu-uGjVR-f5hnaTQtNTw-DakQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 17, 2017 at 5:06 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> The A711 has 1024x600 LVDS panel, with a PWM-based backlight. Add it to our
> DT.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

Though I think tcon0 could be enabled by default all the time.
