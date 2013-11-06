From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 6 Nov 2013 12:40:17 +0100
Subject: [PATCH 01/13] dma: ste_dma40: Expand DT binding to accept
 'high-priority channel' flag
In-Reply-To: <1383732985-18928-2-git-send-email-lee.jones@linaro.org>
References: <1383732985-18928-1-git-send-email-lee.jones@linaro.org>
 <1383732985-18928-2-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdaVPy8yuhYKohL7ewnmT5y7QrQ7ig2qf4t49YZ-+noDvQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 6, 2013 at 11:16 AM, Lee Jones <lee.jones@linaro.org> wrote:

> --- a/Documentation/devicetree/bindings/dma/ste-dma40.txt
> +++ b/Documentation/devicetree/bindings/dma/ste-dma40.txt
> @@ -50,6 +50,9 @@ Each dmas request consists of 4 cells:
>          0x00000008: Use fixed channel:
>                  Use automatic channel selection when unset
>                  Use DMA request line number when set
> +        0x00000010: Set channel as high priority:
> +                Normal priority when unset
> +                High priority when set

We should probably switch these magic numbers to #defines
but it's another subject so
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
