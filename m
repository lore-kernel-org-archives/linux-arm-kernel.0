From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 3 Nov 2011 17:19:06 +0100
Subject: [PATCH V2] spi/pl022: Enable clock in probe
In-Reply-To: <1320335741-5309-1-git-send-email-ulf.hansson@stericsson.com>
References: <1320335741-5309-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <CACRpkdamE9Qrah9Fc+b86QcohZ7Pnzsh3nNHvdf_6-HCTTPYhQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 3, 2011 at 4:55 PM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:

> Make sure we enable the clock before leaving probe.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
> ---
>
> Changes in v2:
> ? ? ? ?-Remove runtime_idle

Looking good
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Please put this v2 in Russell's tracker.
Linus
