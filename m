From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 24 Apr 2014 14:54:53 +0200
Subject: [PATCH 2/4] dma: ste_dma40: Don't require CONFIG_PM_RUNTIME
In-Reply-To: <1398282724-2607-2-git-send-email-ulf.hansson@linaro.org>
References: <1398282724-2607-1-git-send-email-ulf.hansson@linaro.org>
 <1398282724-2607-2-git-send-email-ulf.hansson@linaro.org>
Message-ID: <CACRpkdZ1x4XRTgdmRon2TqSdCbqbKf8ojSOgGzGGA38QPNvjUg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 23, 2014 at 9:52 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> While probing, don't rely on CONFIG_PM_RUNTIME to be configured.
> Instead, let's power up the device and make it fully operational.
> Update the runtime PM status to reflect the active state.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
