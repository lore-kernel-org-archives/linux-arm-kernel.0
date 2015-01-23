From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 23 Jan 2015 11:56:36 +0100
Subject: [PATCH] clk: ux500: Drop use of clk-private.h
In-Reply-To: <1421955259-8875-1-git-send-email-sboyd@codeaurora.org>
References: <1421955259-8875-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <CACRpkdY8vDwSpTWkGPTkAHsqhFdhFDTy7zohWFoa8TF=yj4+Yg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 22, 2015 at 8:34 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:

> These drivers don't need to include clk-private.h. Remove the
> include.
>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
