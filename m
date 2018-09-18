From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 18 Sep 2018 12:44:29 -0700
Subject: [PATCH v2 04/22] pinctrl: mediatek: extend struct mtk_pin_desc to
 pinctrl-mtk-common-v2.c
In-Reply-To: <8afc61bff2a4146731e5696f440c0eeaaf0ea341.1536404280.git.sean.wang@mediatek.com>
References: <cover.1536404280.git.sean.wang@mediatek.com>
 <8afc61bff2a4146731e5696f440c0eeaaf0ea341.1536404280.git.sean.wang@mediatek.com>
Message-ID: <CACRpkdaLx_gxGMqumbRKVQA5asB0w+WA5nPgETiq6xQ=QzYJig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 8, 2018 at 4:07 AM <sean.wang@mediatek.com> wrote:

> From: Sean Wang <sean.wang@mediatek.com>
>
> This patch introduces a data structure mtk_pin_desc, which is used to
> provide information per pin characteristic such as driving current,
> eint number and a driving index, that is used to lookup table describing
> the details about the groups of driving current by which the pin is able
> to adjust the driving strength so that the driver could get the
> appropriate driving group when calls .pin_config_get()/set().
>
> Signed-off-by: Ryder.Lee <ryder.lee@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

Patch applied.

Yours,
Linus Walleij
