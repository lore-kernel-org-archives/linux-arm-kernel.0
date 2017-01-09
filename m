From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 9 Jan 2017 15:43:41 +0100
Subject: [PATCH 2/3] pinctrl: sunxi: Add common sun5i pinctrl driver
In-Reply-To: <fd94b0b46841a455b1f1f68c2da801957d0748ac.1483911013.git-series.maxime.ripard@free-electrons.com>
References: <cover.53580d3fc31eec98682d3d81f17be89610d397ee.1483911013.git-series.maxime.ripard@free-electrons.com>
 <fd94b0b46841a455b1f1f68c2da801957d0748ac.1483911013.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CACRpkdaNdsvy+SbOyCvbppK4dEs_=8Zmf4CQhsedTt8aig8+BQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 8, 2017 at 10:31 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:

> The sun5i SoCs (A10s, A13, GR8) are all based on the same die fit in
> different packages. Hence, the pins and functions available are just the
> based on the same set, each SoC having a different subset.
>
> Introduce a common pinctrl driver that supports multiple variants to allow
> to put as much as we can in common.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Patch applied.

Yours,
Linus Walleij
