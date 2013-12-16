From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 16 Dec 2013 13:14:48 +0100
Subject: [PATCH 1/1] usb: musb: ux500_dma: fix potential NULL dereference
 error
In-Reply-To: <1386931648-1540-1-git-send-email-lee.jones@linaro.org>
References: <1386931648-1540-1-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdZrCU-rVmZy-UBzi1sxfk21xtbwMPT6T7UMj=kZ1q5rxg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 13, 2013 at 11:47 AM, Lee Jones <lee.jones@linaro.org> wrote:

> static checker warning: "drivers/usb/musb/ux500_dma.c:335
> ux500_dma_controller_start()
>          error: potential NULL dereference 'param_array'."
>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
