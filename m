From: olof@lixom.net (Olof Johansson)
Date: Sun, 15 Sep 2013 11:52:55 -0700
Subject: [PATCH 0/6] deletion of the Shark machine
In-Reply-To: <201309152015.12676.arnd@arndb.de>
References: <1379069467-3974-1-git-send-email-linus.walleij@linaro.org>
 <201309152015.12676.arnd@arndb.de>
Message-ID: <CAOesGMgg8LB862bbEPUiEREAVu4UaGRMJWO_sphvyep1aCqDyA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 15, 2013 at 11:15 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 13 September 2013, Linus Walleij wrote:
>> The RFC series were not met by any protests from active users
>> so this is an iteration of the series as sharp material for
>> v3.13. After collecting ACKs a pull request will be made to
>> the ARM SoC tree.
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
>
> Note that although you just ask for Acks from the other subsystem maintainers
> here, I think it would be just as well to apply some or all of the patches
> in subsystem trees. Since the code is just going away, there is no requirement
> to do it atomically.

Agreed, I was thinking about that the other day too. The main reason
to keep the code together would be in case someone speaks up and nacks
the platform piece -- if the driver pieces have moved ahead then
they'd need to be reverted.

The alternative is to delay the driver patches a bit until the
platform has been removed. Either way, we can sort it out in case we
need to do a 180 turnaround. :)


-Olof
