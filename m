From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 13 Aug 2013 08:14:10 +0200
Subject: [PATCH 2/9] clk: nomadik: Fix incorrect placement of __initconst
In-Reply-To: <1376298847-21828-2-git-send-email-sachin.kamat@linaro.org>
References: <1376298847-21828-1-git-send-email-sachin.kamat@linaro.org>
 <1376298847-21828-2-git-send-email-sachin.kamat@linaro.org>
Message-ID: <CACRpkdb7TzhPnKyKbXGAf-w_XAW-ahvM9nXUW13fp-+kLsXy8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 12, 2013 at 11:14 AM, Sachin Kamat <sachin.kamat@linaro.org> wrote:

> __initconst should be placed between the variable name and equal
> sign for the variable to be placed in the intended section.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
