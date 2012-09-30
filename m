From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 30 Sep 2012 23:47:26 +0200
Subject: [PATCH 3/3] spi: spi-pl022: Minor simplification for runtime pm
In-Reply-To: <1348831266-16721-4-git-send-email-ulf.hansson@stericsson.com>
References: <1348831266-16721-1-git-send-email-ulf.hansson@stericsson.com>
 <1348831266-16721-4-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <CACRpkdZLWdGZKazF6su2NFMa_NK2+L1y+C-CpBwWW6LA9Lqfbw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 28, 2012 at 1:21 PM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:

> From: Ulf Hansson <ulf.hansson@linaro.org>
>
> In probe pm_runtime_put_autosuspend has the same effect as doing
> pm_runtime_put. This due to upper layer in driver core is preventing
> the device from being runtime suspended by a pm_runtime_get*.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
