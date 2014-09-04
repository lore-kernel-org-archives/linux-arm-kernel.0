From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 4 Sep 2014 21:41:45 +0200
Subject: [PATCH 0/3] clps711x for 3.18
In-Reply-To: <1408451506-8001-1-git-send-email-shc_work@mail.ru>
References: <1408451506-8001-1-git-send-email-shc_work@mail.ru>
Message-ID: <201409042141.45745.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 19 August 2014, Alexander Shiyan wrote:
> Here is a CLPS711X patchset for 3.18. Please apply this to arm-soc tree.
> 
> Alexander Shiyan (3):
>   ARM: clps711x: Switch CLPS711X subarch to use clk and clocksource
>     driver
>   ARM: clps711x: edb7211: Use new PWM driver for backlight
>   ARM: clps711x: Add SOC BUS support


Applied the first patch to next/cleanup, and the other two to next/soc.

Thanks for the reminder.

	Arnd
