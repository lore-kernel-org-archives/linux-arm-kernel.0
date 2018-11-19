From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 19 Nov 2018 15:14:19 +0100
Subject: [PATCH] pinctrl: mediatek: Convert to using %pOFn instead of
 device_node.name
In-Reply-To: <20181116220540.17222-4-robh@kernel.org>
References: <20181116220540.17222-1-robh@kernel.org>
 <20181116220540.17222-4-robh@kernel.org>
Message-ID: <CACRpkdZnS4BkUJN_rjjPcCQAMDd0_4KZ_LgmYYtmuuBuRg6jgw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 16, 2018 at 11:06 PM Rob Herring <robh@kernel.org> wrote:

> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
>
> Cc: Sean Wang <sean.wang@kernel.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: linux-mediatek at lists.infradead.org
> Cc: linux-gpio at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Patch applied with Sean's ACK.

Yours,
Linus Walleij
