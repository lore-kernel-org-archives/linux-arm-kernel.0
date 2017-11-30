From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 30 Nov 2017 14:42:30 +0100
Subject: [PATCH] pinctrl: pxa: pxa2xx: add missing
 MODULE_DESCRIPTION/AUTHOR/LICENSE
In-Reply-To: <20171120205804.88061-1-jc@linux.com>
References: <20171120205804.88061-1-jc@linux.com>
Message-ID: <CACRpkdZLDoW88nxqf3QG142jTDj8H-GCuH38QSMAee6zjv0LUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 20, 2017 at 9:58 PM, Jesse Chan <jc@linux.com> wrote:

> This change resolves a new compile-time warning
> when built as a loadable module:
>
> WARNING: modpost: missing MODULE_LICENSE() in drivers/pinctrl/pxa/pinctrl-pxa2xx.o
> see include/linux/module.h for more information
>
> This adds the license as "GPL v2", which matches the header of the file.
>
> MODULE_DESCRIPTION and MODULE_AUTHOR are also added.
>
> Signed-off-by: Jesse Chan <jc@linux.com>

Patch applied.

Yours,
Linus Walleij
