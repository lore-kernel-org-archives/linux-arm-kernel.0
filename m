From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 23 Feb 2016 10:34:46 +0100
Subject: [PATCH 11/11] ARM: versatile: move CLCD configuration to device
 tree
In-Reply-To: <CACRpkdbnLgVsrSAu87wxSwktK3ftJzbQLXjU8y65tq=9Ynxicw@mail.gmail.com>
References: <1454594660-7532-1-git-send-email-linus.walleij@linaro.org>
 <1454594660-7532-12-git-send-email-linus.walleij@linaro.org>
 <CACRpkdbnLgVsrSAu87wxSwktK3ftJzbQLXjU8y65tq=9Ynxicw@mail.gmail.com>
Message-ID: <3695074.sKSIyOjpjD@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 23 February 2016 10:08:05 Linus Walleij wrote:
> I will think of a better solution, if any, for this for v4.6, but will
> put forward something that handles the Nomadik and all the
> other ARM reference designs for now.
> 

How about still describing all known panels in the DT marked 'status="disabled"',
but then having a minimal piece of board specific code that just enables
whichever one gets detected at boot time?

	Arnd
