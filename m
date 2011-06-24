From: pawel.moll@arm.com (Pawel Moll)
Date: Fri, 24 Jun 2011 11:29:23 +0100
Subject: [PATCH 0/3] consolidate ARM refdesign LEDs
In-Reply-To: <1308763972-24716-1-git-send-email-linus.walleij@stericsson.com>
References: <1308763972-24716-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1308911363.14198.32.camel@hornet.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Morning,

> This creates a common LED trigger for the CPU activity LEDs in
> the leds subsystem, and removes the custom code from RealView
> and Versatile boards.
> 
> Inspired by Bryan Wu's LED consolidation work.
> 
> Linus Walleij (3):
>   leds: create a trigger for ARM CPU activity
>   mach-realview: retire custom LED code
>   mach-versatile: retire custom LED code

You made my day :-)

Acked-by: Pawel Moll <pawel.moll@arm.com>

Cheers!

Pawe?
