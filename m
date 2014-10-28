From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 28 Oct 2014 11:00:01 +0100
Subject: [PATCH 7/7] mfd: ab8500: Decrement the power supply's device
 reference counter
In-Reply-To: <1413290117-13082-8-git-send-email-k.kozlowski@samsung.com>
References: <1413290117-13082-1-git-send-email-k.kozlowski@samsung.com>
 <1413290117-13082-8-git-send-email-k.kozlowski@samsung.com>
Message-ID: <CACRpkdbtCU-c6EuYPN0oxUS2TWsrBSh6zQ2kO4FijzzE=asFmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 14, 2014 at 2:35 PM, Krzysztof Kozlowski
<k.kozlowski@samsung.com> wrote:

> Use power_supply_put() to decrement the power supply's device reference
> counter.
>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
