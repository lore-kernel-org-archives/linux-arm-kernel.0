From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 18 Oct 2013 11:49:34 +0100
Subject: [PATCH 2/5 v2] mfd: tc3589x: Detect the precise version
In-Reply-To: <1382089905-20730-1-git-send-email-linus.walleij@linaro.org>
References: <1382089905-20730-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20131018104934.GS19112@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 18 Oct 2013, Linus Walleij wrote:

> Instead of detecting the "tc3589x" and hard-coding the number of
> GPIO pins to 24, encode all the possible subtypes and set the
> number of GPIO pins from the type.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Compress the switch tree to the two variables we currently
>   have to deal with.

So you chose my least favourite alternative. ;)

> ---
>  drivers/mfd/tc3589x.c | 37 +++++++++++++++++++++++++++++++++++--
>  1 file changed, 35 insertions(+), 2 deletions(-)

Anyway... patch applied.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
