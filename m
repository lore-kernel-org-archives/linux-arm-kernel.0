From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 8 Sep 2016 00:28:24 +0200
Subject: [PATCH 0/6] SA11x0 serial updates
In-Reply-To: <20160905122810.GP1041@n2100.armlinux.org.uk>
References: <20160829100232.GC1041@n2100.armlinux.org.uk>
 <20160829102328.GA28796@n2100.armlinux.org.uk>
 <20160829110157.GE1041@n2100.armlinux.org.uk>
 <20160829112540.GF1041@n2100.armlinux.org.uk>
 <20160829120531.GG1041@n2100.armlinux.org.uk>
 <CACRpkdZFZVq92UAiq+dsHabyEk+_AbQ_B3SOETGru-8Kbp=h9Q@mail.gmail.com>
 <20160905122810.GP1041@n2100.armlinux.org.uk>
Message-ID: <CACRpkdaFsrm7V19s4VntqPnkY52xjV3_Bz+nW5fVrfWERRx=Rg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 5, 2016 at 2:28 PM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Mon, Sep 05, 2016 at 11:09:38AM +0200, Linus Walleij wrote:
>> On Mon, Aug 29, 2016 at 2:05 PM, Russell King - ARM Linux
>> <linux@armlinux.org.uk> wrote:
>>
>> > This series converts SA11x0 serial to make use of the mctrl helpers
>> > where appropriate.  This allows us to remove several board-specific
>> > callbacks.
>>
>> >From GPIO and H3600 point of view:
>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>
> Thanks - did you check that the appropriate GPIOs were claimed for
> serial in gpio's debugfs?

Getting to it tomorrow (didn't forget about it).

I was working from home the last two days and back to the office where
I have all the hardware tomorrow. Will test it and report back. Will also
try to investigate the PCMCIA probe bounce with -2.

Yours,
Linus Walleij
