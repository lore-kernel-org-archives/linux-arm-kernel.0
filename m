From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 26 Feb 2014 00:49:40 +0100
Subject: SA110 MMU problem, any hints?
Message-ID: <CACRpkdaph0_mnJsDBC7_5+wWm18cygf70GoJ-QR0fPuyN0Xw=A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

after doing some painful bringup on a Netwinder
machine, I have run into an unspecified MMU bug on the SA110.
Basically the kernel bootstrap bugs out before start_kernel()
so it's on a very basic level.

If I turn off CONFIG_MMU it actually boots all the way until attempting
to mount root, with boot logo, VGA console and everything.

Given  that you made some Footbridge patches recently I guess
you have it working? No special tweaks?

Any hints welcome!

Yours,
Linus Walleij
