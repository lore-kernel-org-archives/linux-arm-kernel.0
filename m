From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 9 Jan 2017 15:42:32 +0100
Subject: [PATCH 1/3] pinctrl: sunxi: Add pinctrl variants
In-Reply-To: <e664022c7ea8177305c5c62676bd64f949caf7ab.1483911013.git-series.maxime.ripard@free-electrons.com>
References: <cover.53580d3fc31eec98682d3d81f17be89610d397ee.1483911013.git-series.maxime.ripard@free-electrons.com>
 <e664022c7ea8177305c5c62676bd64f949caf7ab.1483911013.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CACRpkdao7X0Ut2hNGpqu_anTKeSB60Vay0MigE35un4i1VceLQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 8, 2017 at 10:31 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:

> Some SoCs are either supposed to be pin compatible (A10 and A20 for
> example), or are just repackaged versions of the same die (A10s, A13, GR8).
>
> In those case, having a full blown pinctrl driver just introduces
> duplication in both data size and maintainance effort.
>
> Add a variant option to both pins and functions to be able to limit the
> pins and functions described only to a subset of the SoC we support with a
> given driver.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Patch applied.

Yours,
Linus Walleij
