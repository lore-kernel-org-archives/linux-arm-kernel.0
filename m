From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 29 May 2017 10:17:59 +0200
Subject: [PATCH] pinctrl: zte: fix group_desc initialization
In-Reply-To: <1495461575-29488-1-git-send-email-shawnguo@kernel.org>
References: <1495461575-29488-1-git-send-email-shawnguo@kernel.org>
Message-ID: <CACRpkdaROhkVtqZSgoVPyL8A7K5CR=9+1mq1uP-EnNZdQfdJGw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 22, 2017 at 3:59 PM, Shawn Guo <shawnguo@kernel.org> wrote:

> From: Shawn Guo <shawn.guo@linaro.org>
>
> There are a couple of issues with group_desc initialization in function
> zx_pinctrl_build_state().
>
>  - num_pins is not initialized and remains zero.
>  - pins shouldn't be initialized with a pointer to variable in the
>    stack.
>
> With them fixed, pin_request() in pinmux_enable_setting() can be invoked
> correctly.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Patch applied.

Yours,
Linus Walleij
