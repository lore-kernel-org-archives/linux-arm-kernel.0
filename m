From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 3 May 2011 23:41:24 +0200
Subject: [v2 0/7] OMAP: GPIO: Use PM runtime framework
In-Reply-To: <87y62ng3f8.fsf@ti.com>
References: <1303139217-10285-1-git-send-email-charu@ti.com>
	<20110419062633.GA15620@atomide.com> <87r58w4gq3.fsf@ti.com>
	<20110421054221.GF5918@atomide.com>
	<BANLkTi=s=KzeZfvoq7Efg2=Ceahz_fQxMA@mail.gmail.com>
	<20110426072941.GA3755@atomide.com>
	<BANLkTimGU+kODvL0dC2x7UNSz0TReKveXQ@mail.gmail.com>
	<87y62ng3f8.fsf@ti.com>
Message-ID: <BANLkTimW1PTavvxjPujVMEV38vzMvja9mw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/5/3 Kevin Hilman <khilman@ti.com>:

> Are you OK with a move of the current OMAP GPIO drivers (rather ugly)
> into drivers/gpio first, followed by the cleanup/restructure patches?

In my case I actually did some cleanup after moving the driver for
U300, but I think this is a question to the GPIO maintainer who
I want to ACK this stuff in the end.

Grant?

You can always squash it later ...

Linus Walleij
