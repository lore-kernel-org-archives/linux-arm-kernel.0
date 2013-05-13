From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 13 May 2013 21:09:38 +0200
Subject: [PATCH] serial: pl011: protect attribute read from NULL platform
 data struct
In-Reply-To: <1368103855-28363-1-git-send-email-lee.jones@linaro.org>
References: <1368103855-28363-1-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdZR3AsGyCUH=cbskcZPs0PVBjH6QXUGkD+KG8SzGMMOKg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 9, 2013 at 2:50 PM, Lee Jones <lee.jones@linaro.org> wrote:

> It's completely feasible that platform data will be empty i.e. when
> booting with Device Tree with no device AUXDATA. So we must protect
> it's use in these use-cases, or risk a kernel Oops.
>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.cz>
> Cc: linux-serial at vger.kernel.org
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
> *******                                                        *******
> If this issue has not already been fixed, this patch should be applied
> during the v3.10 -rc:s, as it fixes a serious bug which was introduced
> in the merge-window.
> *******                                                        *******

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

You should probably put Greg on To: so that he picks this up for
the -rc:s ASAP.

Yours,
Linus Walleij
