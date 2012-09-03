From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 3 Sep 2012 14:02:34 +0200
Subject: [PATCH 4/4] ARM: ks8695: convert to generic time and clocksource
In-Reply-To: <201209021849.54348.arnd@arndb.de>
References: <1346264842-20411-1-git-send-email-linus.walleij@linaro.org>
 <504057A8.7030302@snapgear.com>
 <CACRpkdZ0Gw5H_yRcN2CmC+F8NtUcySTrLehuzZdWrbDwL4HHWw@mail.gmail.com>
 <201209021849.54348.arnd@arndb.de>
Message-ID: <CACRpkdab72Z86i21TNohS0YO=Bav7eQgHwQyXa0tXQB=0hhgAg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 2, 2012 at 8:49 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 31 August 2012, Linus Walleij wrote:

>> (BTW I had not clue the 68K maintainer had a platform like
>> this, fun!)
>
> Note that this platform is one of those we talked about removing
> from the kernel for potentially being completely unused.

This clock stuff was a lackmus test from my side. The idea
was that if noone tested the patches I would instead
propose a patch deleting the platform.

Guess what: Greg jumps out like jack-in-the-box. I suspect
some of these platforms may have more users than we
believe.

Unsure about the genesis though, it has not even
compiled for a while. I'm poking some of them one by one.

Yours,
Linus Walleij
