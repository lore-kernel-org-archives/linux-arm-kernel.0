From: 21cnbao@gmail.com (Barry Song)
Date: Sun, 21 Aug 2011 22:42:32 +0800
Subject: [PATCH 0/4 v4] pin controller subsystem v4
In-Reply-To: <1313747619-32222-1-git-send-email-linus.walleij@stericsson.com>
References: <1313747619-32222-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <CAGsJ_4z7s-ibmUuR1DA6Jps030dRrnE8M0dUWHoMhMPFtyyY_A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> - Rewrite the interaction with the GPIO subsystem - the pin
> ?controller descriptor now handles this by defining an offset
> ?into the GPIO numberspace for its handled pin range. This is
> ?used to look up the apropriate pin controller for a GPIO pin.
> ?Then that specific GPIO range is matched 1-1 for the target
> ?controller instance.
...
>
> Linus Walleij (4):
> ?drivers: create a pinmux subsystem v4
> ?pinmux: add a driver for the U300 pinmux
> ?amba: request muxing for PrimeCell devices
> ?mach-u300: activate pinmux driver, delete old padmux driver

it seems there is not an actual example that gpio requests pin from
pinctrl yet. i might give one on SiRFprimaII.

Thanks
Barry
