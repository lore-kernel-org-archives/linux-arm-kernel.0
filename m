From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 Aug 2012 10:55:59 +0200
Subject: [PATCH 06/22] ASoC: Ux500: Enable ux500 MSP driver for Device Tree
In-Reply-To: <1344527268-5964-7-git-send-email-lee.jones@linaro.org>
References: <1344527268-5964-1-git-send-email-lee.jones@linaro.org>
 <1344527268-5964-7-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdb09UnPj6xV-rNxoeUS2yPLurA+n6zygWEA3_7OQfb0nA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 9, 2012 at 5:47 PM, Lee Jones <lee.jones@linaro.org> wrote:

> Register both parts of the MSP driver from Device Tree so that they
> are probed when Device Tree is enabled. Also, as there is platform
> data involved, we ensure that there is allocated memory to place the
> configuration into and that the correct information is extracted from
> the DT binary.
>
> CC: alsa-devel at alsa-project.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Looks like it's doing what's intended...
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
