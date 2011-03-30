From: alex.bluesman.smirnov@gmail.com (Alexander Smirnov)
Date: Wed, 30 Mar 2011 06:23:56 -0000
Subject: AT91SAM9G45-EK-ES support
Message-ID: <AANLkTi=bK5T66eyYtq0z6Ey2jXqbUKMi3kK-U8u2aiEC@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello all,

I'm working with Atmel AT91SAM9G45-EK-ES board. I built the latest upstream
kernel, but it doesn't work. There is problem with machine ID. Currently
boards with AT91SAM9G45-EK ID only are supported, support for EKES boards
was removed (as I see in git log). What's the reason of such changes and how
can I bring up my board without hacks?

Also, could anyone please describe current status of SAM9G45 boards support
in mainline. Do all the drivers work, are they up-to-date?

Thank you a lot,
Alexander
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110330/ea754cd3/attachment-0001.html>
