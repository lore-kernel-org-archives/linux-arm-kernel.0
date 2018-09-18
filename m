From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 18 Sep 2018 12:49:37 -0700
Subject: [PATCH v2 09/22] pinctrl: mediatek: add advanced pull related
 support to pinctrl-mtk-common-v2.c
In-Reply-To: <aa213c9af6f9261f2ba91055785f0058d615bc4d.1536404280.git.sean.wang@mediatek.com>
References: <cover.1536404280.git.sean.wang@mediatek.com>
 <aa213c9af6f9261f2ba91055785f0058d615bc4d.1536404280.git.sean.wang@mediatek.com>
Message-ID: <CACRpkdaAWZYeQiSBuZQLwhQMoKryGB1aktQ4dpcarN7TNnZh1Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 8, 2018 at 4:07 AM <sean.wang@mediatek.com> wrote:

> From: Sean Wang <sean.wang@mediatek.com>
>
> There are some specific pins (i.e. MMC/SD) need specific registers to
> turn on/off the 10K & 50k(75K) resistors when pull up/down.
>
> Therefore, this patch adds the custom prarmeters so that the user could
> control it through device tree.
>
> Signed-off-by: Ryder.Lee <ryder.lee@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

Patch applied.

Yours,
Linus Walleij
