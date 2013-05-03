From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 3 May 2013 22:11:00 +0200
Subject: [PATCH 15/63] ARM: ux500: Remove unused 'data_width' attributes
 from UART DMA configs
In-Reply-To: <1367591569-32197-16-git-send-email-lee.jones@linaro.org>
References: <1367591569-32197-1-git-send-email-lee.jones@linaro.org>
 <1367591569-32197-16-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdZXTdkTkE2xW=ktuiTHddxJeqNkVwKFT3LnsitCjsTmQw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 3, 2013 at 4:32 PM, Lee Jones <lee.jones@linaro.org> wrote:

> DMA configuration data is now allocated in the UART driver, so these
> are just ignored.
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Patch applied to my ux500-dma40 branch.

Thanks!
Linus Walleij
