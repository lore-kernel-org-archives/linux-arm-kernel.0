From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 8 Jun 2016 14:15:55 +0200
Subject: [PATCH 5/8] dmaengine: ste_dma40: Only calculate residue if
 txstate exists.
In-Reply-To: <1465321121-22238-6-git-send-email-peter.griffin@linaro.org>
References: <1465321121-22238-1-git-send-email-peter.griffin@linaro.org>
 <1465321121-22238-6-git-send-email-peter.griffin@linaro.org>
Message-ID: <CACRpkdaFhAbWtoOmmK4m-MaQsNgPya4mEOmAUDZmNNxvRotY3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 7, 2016 at 7:38 PM, Peter Griffin <peter.griffin@linaro.org> wrote:

> There is no point calculating the residue if there is
> no txstate to store the value.
>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
