From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 18 Sep 2018 12:56:45 -0700
Subject: [PATCH v2 14/22] pinctrl: mediatek: add multiple register bases
 support to pinctrl-mtk-common-v2.c
In-Reply-To: <8c4a741e7ed695d85844a1a550b956d767661b44.1536404280.git.sean.wang@mediatek.com>
References: <cover.1536404280.git.sean.wang@mediatek.com>
 <8c4a741e7ed695d85844a1a550b956d767661b44.1536404280.git.sean.wang@mediatek.com>
Message-ID: <CACRpkdZbXDv2um0jbGWu8OY38sdJg_1ApqDQcj1GXJ5P_E-tuQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 8, 2018 at 4:07 AM <sean.wang@mediatek.com> wrote:

> From: Sean Wang <sean.wang@mediatek.com>
>
> Certain SoC own multiple register base for accessing each pin groups,
> it's easy to be done with extend struct mtk_pin_field_calc to support
> the kind of SoC such as MT8183.
>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

Patch applied.

Yours,
Linus Walleij
