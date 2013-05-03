From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 3 May 2013 22:09:04 +0200
Subject: [PATCH 14/63] ARM: ux500: Remove unused 'data_width' attributes
 from SSP DMA configs
In-Reply-To: <1367591569-32197-15-git-send-email-lee.jones@linaro.org>
References: <1367591569-32197-1-git-send-email-lee.jones@linaro.org>
 <1367591569-32197-15-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdbVhxmei-VgYwD2-wO4i7Otz4NROhZ01HzBWwTk2CK2KQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 3, 2013 at 4:32 PM, Lee Jones <lee.jones@linaro.org> wrote:

> DMA configuration data is now allocated in the SSP driver, so these
> are just ignored.
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Patch applied to my ux500-dma40 branch.

Thanks!
Linus Walleij
