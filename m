From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 16 May 2014 15:37:38 +0200
Subject: [PATCH 04/16] mfd: db8500-prcmu: Make mfd_cell array const
In-Reply-To: <1399978733-13662-4-git-send-email-k.kozlowski@samsung.com>
References: <1399978733-13662-1-git-send-email-k.kozlowski@samsung.com>
 <1399978733-13662-4-git-send-email-k.kozlowski@samsung.com>
Message-ID: <CACRpkdaxeW55Aqwfst1Z3YjZ2uh1M5ZaH0rPhPxKe+6nd599sQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 13, 2014 at 12:58 PM, Krzysztof Kozlowski
<k.kozlowski@samsung.com> wrote:

> mfd_add_devices() expects array of struct mfd_cell to be const.
>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Cc: Mattias Nilsson <mattias.i.nilsson@stericsson.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: linux-arm-kernel at lists.infradead.org

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
