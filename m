From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 21 Oct 2016 10:51:09 +0800
Subject: [PATCH 1/6] ARM: sun5i: chip: Enable Wi-Fi SDIO chip
In-Reply-To: <468cbaad185a2bde92f1015a1c286f1e1ef55850.1476704881.git-series.maxime.ripard@free-electrons.com>
References: <cover.92d041a0a6fe40f1c8839cabb70247445eaffdfb.1476704881.git-series.maxime.ripard@free-electrons.com>
 <468cbaad185a2bde92f1015a1c286f1e1ef55850.1476704881.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v66H22eM6MP2t+Ntuj6UX9TcLSMzH0DHcLnBq5DqqKoXHw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 17, 2016 at 7:48 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> The WiFi chip is powered through a GPIO and two regulators in parallel.
> Since that case is not supported yet, just set them as always on before we
> rework the regulator framework to deal with those.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
