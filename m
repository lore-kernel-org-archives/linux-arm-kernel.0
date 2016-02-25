From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 25 Feb 2016 15:13:26 +0100
Subject: [PATCH 00/50] pinctrl: Add and use devm_ apis for
 pinctrl_{register, unregister}
In-Reply-To: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
References: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <CACRpkdZjv2KZ0AtC9oBytmSdS+=T+kC8PoJVt-RawE8Np8p40w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 24, 2016 at 2:15 PM, Laxman Dewangan <ldewangan@nvidia.com> wrote:

> Add resource manageemnt APIs fro pinctrl_register() and pinctrl_unregister()
> and use these new APIs on hw driver to reduce the error path code and
> remove callback for driver.

As you can probably guess I like this too, so wait a while, collect ACKs
and send me a branch to pull for this too.

Yours,
Linus Walleij
