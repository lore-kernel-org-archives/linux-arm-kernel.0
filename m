From: alex.bluesman.smirnov@gmail.com (Alexander Smirnov)
Date: Fri, 29 Jun 2012 16:53:01 +0400
Subject: RF231 transceiver on at91sam9g20ek board
In-Reply-To: <4FEC7369.3050003@atmel.com>
References: <CAJmB2rDxv45OP4otn7rmQcpzCvLujKm0j9_OqNW6PoyHuarTLw@mail.gmail.com>
 <201206221834.41869.arnd@arndb.de>
 <CAJmB2rBcRuNe0QfEGoJN1rQnRnr33gyE=nLt3Az=mGEWuR7mCg@mail.gmail.com>
 <201206281430.21916.arnd@arndb.de> <4FEC7369.3050003@atmel.com>
Message-ID: <CAJmB2rBpa=iK6yhd3=CikampfypU+4MaUfM-GQMLZhN7QNUteA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Dear Alexander,
>
> There has been an attempt to move the spi-atmel.c driver to device tree.
> You can check the status of the discussion in by searching the message
> subjects:
>
> [PATCH 1/4 v4] of_spi: add generic binding support to specify cs gpio
> [PATCH 1/4 v5] of_spi: add generic binding support to specify cs gpio
>
> I guess that you can take these patches as examples for moving to device
> tree on your AT91 based board (beware you should set pin muxing in your
> bootloader).
>
> There is a "work in progress" snapshot of this work in at91 git tree/branch:
> git://github.com/at91linux/linux-at91.git ? ghnew/j/for-3.5-wip
>
> commit: 5f31f2573e7e9369500118e1b8fd026392fc0982
> commit: 93fd57e73502656a139879518b397711cc305c6a

Dear at91 team,

thank you very much for the hints!

Alex

>
> Best regards,
> --
> Nicolas Ferre
>
>
