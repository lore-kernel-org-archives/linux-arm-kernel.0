From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 28 Nov 2012 16:48:14 +0100
Subject: [PATCH] mfd: ab8500-core: Fix invalid free of devm_ allocated data
In-Reply-To: <1353673123-32340-1-git-send-email-tushar.behera@linaro.org>
References: <1353673123-32340-1-git-send-email-tushar.behera@linaro.org>
Message-ID: <CACRpkdar_H=siMOrzddgw94uA76bZPCgZPpWVwVE28L47CXjOg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 23, 2012 at 1:18 PM, Tushar Behera <tushar.behera@linaro.org> wrote:

> The objects allocated by devm_* APIs are managed by devres and are
> freed when the device is detached. Hence there is no need to remove
> them explicitly in remove function.
>
> Signed-off-by: Tushar Behera <tushar.behera@linaro.org>

Looks good to me.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
