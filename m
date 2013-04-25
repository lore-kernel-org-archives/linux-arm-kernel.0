From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 25 Apr 2013 15:06:06 +0200
Subject: [PATCH 04/10 v2] usb: musb: ux500: harden checks for platform data
In-Reply-To: <20130424150406.GD9652@gmail.com>
References: <1366729394-11406-1-git-send-email-lee.jones@linaro.org>
 <1366729394-11406-5-git-send-email-lee.jones@linaro.org>
 <20130424150406.GD9652@gmail.com>
Message-ID: <CACRpkdZY7bEH36mMo3fggTuyOhWe-E-YF=BUCt4zBReOzPuk-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 24, 2013 at 5:04 PM, Lee Jones <lee.jones@linaro.org> wrote:

> In its current state, the ux500-musb driver uses platform data pointers
> blindly with no prior checking. If no platform data pointer is passed
> this will Oops the kernel. In this patch we ensure platform data and
> board data are present prior to using them.
>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: linux-usb at vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
