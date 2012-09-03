From: gerg@snapgear.com (Greg Ungerer)
Date: Mon, 3 Sep 2012 22:57:56 +1000
Subject: [PATCH 4/4] ARM: ks8695: convert to generic time and clocksource
In-Reply-To: <CACRpkdab72Z86i21TNohS0YO=Bav7eQgHwQyXa0tXQB=0hhgAg@mail.gmail.com>
References: <1346264842-20411-1-git-send-email-linus.walleij@linaro.org>
 <504057A8.7030302@snapgear.com>
 <CACRpkdZ0Gw5H_yRcN2CmC+F8NtUcySTrLehuzZdWrbDwL4HHWw@mail.gmail.com>
 <201209021849.54348.arnd@arndb.de>
 <CACRpkdab72Z86i21TNohS0YO=Bav7eQgHwQyXa0tXQB=0hhgAg@mail.gmail.com>
Message-ID: <5044A954.4000706@snapgear.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Liunus,

On 09/03/2012 10:02 PM, Linus Walleij wrote:
> On Sun, Sep 2, 2012 at 8:49 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Friday 31 August 2012, Linus Walleij wrote:
>
>>> (BTW I had not clue the 68K maintainer had a platform like
>>> this, fun!)
>>
>> Note that this platform is one of those we talked about removing
>> from the kernel for potentially being completely unused.
>
> This clock stuff was a lackmus test from my side. The idea
> was that if noone tested the patches I would instead
> propose a patch deleting the platform.
>
> Guess what: Greg jumps out like jack-in-the-box.

That is annoying :-)


> I suspect
> some of these platforms may have more users than we
> believe.

I know the guys at www.opengear.com are still building hardware around
the KS8695. And they update to modern kernels from time to time. So its
not completely obsolete yet. I have some SnapGear boards based around it
too, though they went out of production about 2 years ago.

Regards
Greg


-- 
------------------------------------------------------------------------
Greg Ungerer  --  Principal Engineer        EMAIL:     gerg at snapgear.com
SnapGear Group, McAfee                      PHONE:       +61 7 3435 2888
8 Gardner Close,                            FAX:         +61 7 3891 3630
Milton, QLD, 4064, Australia                WEB: http://www.SnapGear.com
