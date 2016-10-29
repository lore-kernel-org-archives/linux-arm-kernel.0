From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 29 Oct 2016 11:08:53 +0200
Subject: [PATCH v3 1/6] pinctrl: sunxi: Deal with configless pins
In-Reply-To: <ae812275bfb0f0ded2a73b571bfcecffcd747126.1476971126.git-series.maxime.ripard@free-electrons.com>
References: <cover.f893b02a9f816dad8fad3986672b05c4b211e2b1.1476971126.git-series.maxime.ripard@free-electrons.com>
 <ae812275bfb0f0ded2a73b571bfcecffcd747126.1476971126.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CACRpkdabSP47+OA5bVwYhqMBvqKGxxG8=Vk94KcdAmkqjsi2pA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 20, 2016 at 3:49 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:

> Even though the our binding had the assumption that the allwinner,pull and
> allwinner,drive properties were optional, the code never took that into
> account.
>
> Fix that.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Acked-by: Chen-Yu Tsai <wens@csie.org>

Patch applied.

Yours,
Linus Walleij
