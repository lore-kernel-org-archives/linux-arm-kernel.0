From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 30 May 2013 10:44:16 +0200
Subject: [PATCH 27/39] ARM: ux500: Remove ux500-musb platform registation
 when booting with DT
In-Reply-To: <1368611522-9984-28-git-send-email-lee.jones@linaro.org>
References: <1368611522-9984-1-git-send-email-lee.jones@linaro.org>
 <1368611522-9984-28-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdYm8PiQj++w_5=odvpZxOgBmjH4F9yPEFRhN+CGFEE48A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 15, 2013 at 11:51 AM, Lee Jones <lee.jones@linaro.org> wrote:

> Now the ux500-musb driver has been enabled for Device Tree, there is no
> requirement to register it from platform code.
>
> Acked-by: Fabio Baltieri <fabio.baltieri@linaro.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Patch applied to my ux500-dma40 branch on top of the musb
stuff.

Yours,
Linus Walleij
