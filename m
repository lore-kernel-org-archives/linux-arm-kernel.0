From: carlo@endlessm.com (Carlo Caione)
Date: Wed, 14 Oct 2015 18:04:54 +0200
Subject: [PATCH] ARM: meson6: DTS: Fix wrong reg mapping and IRQ numbers
In-Reply-To: <8566547.CSeb89j3FB@wuerfel>
References: <1443696760-8316-1-git-send-email-carlo@caione.org>
 <CAOQ7t2bAQ8RrfssFzAM6m=HGVaQDfcmmqPvmwX4wiAJig9ZVJg@mail.gmail.com>
 <8566547.CSeb89j3FB@wuerfel>
Message-ID: <CAL9uMOHFoZqxdP6e+bb2N0t11P4tsJQHhOTZ-Ch6BA+YNwkG0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 14, 2015 at 5:51 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Saturday 10 October 2015 11:56:23 Carlo Caione wrote:
>> On Thu, Oct 1, 2015 at 12:52 PM, Carlo Caione <carlo@caione.org> wrote:
>> > From: Carlo Caione <carlo@endlessm.com>
>> >
>> > The DTS erronously uses the wrong reg mapping and IRQ numbers for some
>> > UART, WDT and timer nodes. Fix this.
>>
>> Hi Arnd,
>> if you have no complains could you take this into next/dt?
>>
>>
>
> Pulled into next/dt, but please let me know if it should actually go
> into 4.3 instead. It looks like a bugfix patch and perhaps also applies
> to stable?

It is actually, thank you for the reminder. I can resubmit it with
with stable in CC even though I'm pretty sure that ATM the number of
people actually using this DTS is dramatically close to 0.

Thanks,

-- 
Carlo Caione
