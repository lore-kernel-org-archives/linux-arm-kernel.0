From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Tue, 4 Jul 2017 18:51:36 +0300
Subject: [PATCH] gpio: drop unnecessary includes from
 include/linux/gpio/driver.h
In-Reply-To: <CAK7LNATRrngmVFPDSKmUm3Td7RXnSZSPGNF9Ds_y+DU=i7mRag@mail.gmail.com>
References: <1499140415-31677-1-git-send-email-yamada.masahiro@socionext.com>
 <20170704125851.GA20504@sophia>
 <CAK7LNATRrngmVFPDSKmUm3Td7RXnSZSPGNF9Ds_y+DU=i7mRag@mail.gmail.com>
Message-ID: <CAHp75VcfDdSCoU=DZyF1BD0YX9KfmLnptnHU9fgBQY3g-NW7PQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 4, 2017 at 6:43 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> 2017-07-04 21:58 GMT+09:00 William Breathitt Gray <vilhelm.gray@gmail.com>:

> So, I need to think about how to merge this (if the basic idea of this is OK).
>
> Maybe,
>
> [1] Send patches to subsystems (gpio, pinctrl, etc.) for v4.14
> [2] Drop unneeded includes from linux/gpio/driver.h for v4.15

Perhaps, fixing users (drivers!) first. then frameworks / libraries,
at last header itself (in each case perhaps follow the split I
proposed earlier).

My wish is to get gpiolib-acpi patch completely separate from the bunch.

-- 
With Best Regards,
Andy Shevchenko
