From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 24 May 2018 09:39:47 +0200
Subject: [PATCH v1 4/7] pinctrl: mediatek: use generic EINT register maps
 for each SoC
In-Reply-To: <39738efefe94e3a4fb7668a27dd73ae49695dc3b.1526835466.git.sean.wang@mediatek.com>
References: <cover.1526835466.git.sean.wang@mediatek.com>
 <39738efefe94e3a4fb7668a27dd73ae49695dc3b.1526835466.git.sean.wang@mediatek.com>
Message-ID: <CACRpkdYFZLCMJCZ0csV2cU3zGq4c7R2O0PSLk7XiZsj=cyAK7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 20, 2018 at 7:01 PM,  <sean.wang@mediatek.com> wrote:

> From: Sean Wang <sean.wang@mediatek.com>
>
> So far, EINT on each SoC all used exactly identical register map and thus
> it's better that we apply generic register map already supported in EINT
> library and stop copy-n-pasting the same data block and filling into its
> platform data.
>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

Patch applied.

Yours,
Linus Walleij
