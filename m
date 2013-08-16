From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 16 Aug 2013 17:10:35 +0200
Subject: [PATCH 3/9] clk: u300: Fix incorrect placement of __initconst
In-Reply-To: <1376298847-21828-3-git-send-email-sachin.kamat@linaro.org>
References: <1376298847-21828-1-git-send-email-sachin.kamat@linaro.org>
 <1376298847-21828-3-git-send-email-sachin.kamat@linaro.org>
Message-ID: <CACRpkdbhNBgO65gf670NDC0BrdbQcM-V=w462dgkqutrgVLGeA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 12, 2013 at 11:14 AM, Sachin Kamat <sachin.kamat@linaro.org> wrote:

> __initconst should be placed between the variable name and equal
> sign for the variable to be placed in the intended section.
>
> While at it also make 'u300_clk_lookup' static as it is used only
> in this file.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
