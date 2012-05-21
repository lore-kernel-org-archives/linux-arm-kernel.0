From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 21 May 2012 23:46:08 +0200
Subject: [PATCH 16/16] ARM: ux500: Re-enable SMSC911x platform code
 registration during non-DT boots
In-Reply-To: <1337330355-17747-17-git-send-email-lee.jones@linaro.org>
References: <1337330355-17747-1-git-send-email-lee.jones@linaro.org>
 <1337330355-17747-17-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdarTLa3TtKCbXA+rp8wsLgEGG2U2YxFCLBZkxuv5ZUQGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 18, 2012 at 10:39 AM, Lee Jones <lee.jones@linaro.org> wrote:

> The patch to disable SMSC911x registration was applied twice in the upstream
> kernel by mistake. Git interpreted this as 'take the same entry from a
> similar struct' which was close by. This was the wrong thing to do. This patch
> rectifies this error and re-enables SMSC911x registration when Device Tree is
> not enabled.
>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

This patch needs to go first, and into the -rc series.

Thanks,
Linus Walleij
