From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 20 Dec 2012 20:09:29 +0100
Subject: [PATCH 1/4] ARM: ux500: Provide a means to obtain the SMSC9115
 clock when DT is enabled
In-Reply-To: <1355937587-31730-1-git-send-email-lee.jones@linaro.org>
References: <1355937587-31730-1-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdZpe_=qRHG9paz0Rv9wNY2zfuG+xChdq+HVWJ4jvdgSfw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 19, 2012 at 6:19 PM, Lee Jones <lee.jones@linaro.org> wrote:

> Device Tree names devices differently to how some frameworks expect
> them. Until we can move a platform over to the new way of obtaining
> resources, we have to use the OF_DEV_AUXDATA() macros to craft a
> device name which can be used in searches during allocation time.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

I think that the best way to fix this regression is to gather
ACKs from the involved subsystems and push it throug
ARM SoC directly.

I thing Cc: stable at kernel.org needs to be added to all patches
in this set as well.

Yours,
Linus Walleij
