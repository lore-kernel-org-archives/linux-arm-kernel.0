From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 27 Jul 2016 09:32:51 +0200
Subject: debug tip after earlycon is closed?
In-Reply-To: <CAK7LNASrqbt+RzD64zcAMjmBjJqa2sc2UG+mnEX8npZ9DBJodQ@mail.gmail.com>
References: <CAK7LNASrqbt+RzD64zcAMjmBjJqa2sc2UG+mnEX8npZ9DBJodQ@mail.gmail.com>
Message-ID: <3860396.RT1mlU0LAT@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, July 27, 2016 10:23:09 AM CEST Masahiro Yamada wrote:
> [    0.000004] sched_clock: 56 bits at 50MHz, resolution 20ns, wraps
> every 4398046511100ns
> [    0.008254] Console: colour dummy device 80x25
> [    0.012700] console [tty0] enabled
> [    0.016110] bootconsole [uniphier0] disabled

I assume that the original console is on a uart, while the new console
appears to be on the framebuffer. Maybe you have no screen attached?

	Arnd
