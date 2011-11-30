From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 30 Nov 2011 14:06:24 +0100
Subject: [PATCH] mmc: mmci: Fixup error handling for dma
In-Reply-To: <1322578286-18727-1-git-send-email-ulf.hansson@stericsson.com>
References: <1322578286-18727-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <CACRpkdaquN0SfXu=Xy6Z2-TyK0LtT9Amg0T1u50CVCFn6dEe+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 29, 2011 at 3:51 PM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:

> When getting a cmd irq during an ongoing data transfer
> with dma, the dma job were never terminated. This is now
> corrected.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
> Signed-off-by: Per Forlin <per.forlin@stericsson.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks,
Linus Walleij
