From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 24 Aug 2013 23:19:42 +0200
Subject: [PATCH 21/33] clk: ux500: Add Device Tree support for the PRCC
 Kernel clock
In-Reply-To: <201308241000.01649.arnd@arndb.de>
References: <1370521041-32318-1-git-send-email-lee.jones@linaro.org>
 <20130822092130.GB22023@lee--X1>
 <CACRpkdYLJdmhCqXpQ0s5nbxRoFdZ3bLn+hxAhkoGHYfvugc=7A@mail.gmail.com>
 <201308241000.01649.arnd@arndb.de>
Message-ID: <CACRpkdYg=KinRYXd9O9ZdEUfHOHpxh7KJN1TDgTUwP_uFXS6fg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 24, 2013 at 10:00 AM, Arnd Bergmann <arnd@arndb.de> wrote:

> You just reminded me that I'm still sitting on this old patch
> to add lots of #ifdef CONFIG_ATAGS to ux500 in the places that need
> to get cut out. I don't think I'm able to update that patch at
> the moment, but I can send you the old version I have if you
> are interested.

Well, right now we are getting to the point where DT is fully
functional and Lee has just sent a first round of patches
to switch clk to DT and then delete all the ATAG code in one
swift stroke. (With patches to also clean out platform-data
related cruft in the drivers to follow in the next merge window.)

After that it will actually start to look small and nice,
so I think we'll take that path for v3.13.

(Famous last words.)

Yours,
Linus Walleij
