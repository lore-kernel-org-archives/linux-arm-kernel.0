From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 11 Jan 2018 10:42:53 +0100
Subject: [PATCH 1/2] pinctrl: mediatek: mt7622: fix potential
 uninitialized value being returned
In-Reply-To: <a26c40a8ad2af3cf81b31ae34bc82c1ef80d9279.1515514758.git.sean.wang@mediatek.com>
References: <a26c40a8ad2af3cf81b31ae34bc82c1ef80d9279.1515514758.git.sean.wang@mediatek.com>
Message-ID: <CACRpkdY8V7J+vfztrqL5N8eCMLg-85KTfWKDwdiTNeWDtt8yMA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 9, 2018 at 5:28 PM,  <sean.wang@mediatek.com> wrote:

> From: Sean Wang <sean.wang@mediatek.com>
>
> commit d6ed93551320 ("pinctrl: mediatek: add pinctrl driver for MT7622
> SoC") leads to the following static checker warning:

Patch applied.

Yours,
Linus Walleij
