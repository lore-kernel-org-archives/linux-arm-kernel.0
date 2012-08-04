From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 5 Aug 2012 01:16:20 +0200
Subject: [PATCH 2/2] GPIO: gpio-pxa: fix devicetree functions
In-Reply-To: <1343230539-7196-2-git-send-email-zonque@gmail.com>
References: <1343230539-7196-1-git-send-email-zonque@gmail.com>
 <1343230539-7196-2-git-send-email-zonque@gmail.com>
Message-ID: <CACRpkdY6zn+aigZituo37iq=Mttf9Bhn06nyH-A4zQ6mhsByow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 25, 2012 at 5:35 PM, Daniel Mack <zonque@gmail.com> wrote:

> Provide an of_xlate function for the PXA GPIO chips and make it work for
> devicetree environments.
>
> Successfully tested on a PXA3xx board.
>
> Signed-off-by: Daniel Mack <zonque@gmail.com>

Could the PXA maintainers pls have a look at this patch, if you're working
on DT support especially...

BTW: I guess this is not a fix for issues in the current kernel HEAD?
Is it OK to have this for the next (v3.7) cycle?

Yours,
Linus Walleij
