From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 30 May 2013 10:34:00 +0200
Subject: [PATCH 23/39] usb: musb: ux500: harden checks for platform data
In-Reply-To: <1368611522-9984-24-git-send-email-lee.jones@linaro.org>
References: <1368611522-9984-1-git-send-email-lee.jones@linaro.org>
 <1368611522-9984-24-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdbCx4br+2VH7hoPBPUF6Xpb+WDu2kDxUQAGFJxEHk8ffg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 15, 2013 at 11:51 AM, Lee Jones <lee.jones@linaro.org> wrote:

> In its current state, the ux500-musb driver uses platform data pointers
> blindly with no prior checking. If no platform data pointer is passed
> this will Oops the kernel. In this patch we ensure platform data and
> board data are present prior to using them.
>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: linux-usb at vger.kernel.org
> Acked-by: Fabio Baltieri <fabio.baltieri@linaro.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Tentatively applied with Felipe's ACK.

Yours,
Linus Walleij
