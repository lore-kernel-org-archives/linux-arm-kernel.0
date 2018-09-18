From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 18 Sep 2018 12:59:43 -0700
Subject: [PATCH v2 17/22] pinctrl: mediatek: add pinctrl-paris that
 implements the vendor dt-bindings
In-Reply-To: <ed67b2e8e71220a8cd32c9a7e584931af3d83041.1536404280.git.sean.wang@mediatek.com>
References: <cover.1536404280.git.sean.wang@mediatek.com>
 <ed67b2e8e71220a8cd32c9a7e584931af3d83041.1536404280.git.sean.wang@mediatek.com>
Message-ID: <CACRpkdZnD+pKii0nDq7qbQu15uiKycJAK5szCByg=vaVUyDKuQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 8, 2018 at 4:08 AM <sean.wang@mediatek.com> wrote:

> From: Zhiyong Tao <zhiyong.tao@mediatek.com>
>
> Add pinctrl-paris core that implements vendor dt-binding which MediaTek
> tablet, box and smartphone-based SoCs such as MT81xx, MT27xx, and MT67xx
> SoCs really want to depend on. The driver is just completely rewritten
> according to pinctrl-mtk-common.c but uses the new logic from
> pinctrl-mtk-common-v2.c to have an elegant way to support new SoCs in the
> future.
>
> Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

Patch applied.

Yours,
Linus Walleij
