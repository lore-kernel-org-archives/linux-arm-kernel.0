From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 16 Jun 2017 11:24:33 +0200
Subject: [PATCH v3 6/9] pinctrl: mvebu: add driver for Armada CP110 pinctrl
In-Reply-To: <2d71d93a22ed24c45b7ce7b52fa066cc0a14a69f.1497281623.git-series.gregory.clement@free-electrons.com>
References: <cover.d003a5e862e6d732d901a61d1765a349c9a89eef.1497281623.git-series.gregory.clement@free-electrons.com>
 <2d71d93a22ed24c45b7ce7b52fa066cc0a14a69f.1497281623.git-series.gregory.clement@free-electrons.com>
Message-ID: <CACRpkdb6i+O1okCb2tbSECdzjzsyBsff-q-2UQ16gX7yW+Xu8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 12, 2017 at 5:34 PM, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:

> From: Hanna Hawa <hannah@marvell.com>
>
> This commit adds a pinctrl driver for the CP110 part of the Marvell
> Armada 7K and 8K SoCs. The Armada 7K has a single CP110, where almost all
> the MPP pins are available. On the other side, the Armada 8K has two
> CP110, and the available MPPs are split between the master CP110 (MPPs 32
> to 62) and the slave CP110 (MPPs 0 to 31).
>
> The register interface to control the MPPs is however the same as all
> other mvebu SoCs, so we can reuse the common pinctrl-mvebu.c logic.
>
> Signed-off-by: Hanna Hawa <hannah@marvell.com>
> Reviewed-by: Shadi Ammouri <shadi@marvell.com>

Patch applied.

Yours,
Linus Walleij
