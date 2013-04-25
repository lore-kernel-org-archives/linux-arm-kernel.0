From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 25 Apr 2013 10:24:49 +0200
Subject: [PATCH 06/32] ARM: ux500: Strip out duplicate USB DMA
 configuration
In-Reply-To: <1366279934-30761-7-git-send-email-lee.jones@linaro.org>
References: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
 <1366279934-30761-7-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdZ0WTSx814t_N72Mmb=qG+AtW92m2gFvRjg0DTOiQyQLQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 18, 2013 at 12:11 PM, Lee Jones <lee.jones@linaro.org> wrote:

> For the moment at least, the TX and RX channels for DB8500 USB are
> identical, so this patch generalises them into a single structure
> and passes it twice. Once as the TX and again for the RX configuration.
> We're keeping the infrastructure the same i.e. passing the TX and RX
> separately in case they start to differ on latter incarnations of the
> platform.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
