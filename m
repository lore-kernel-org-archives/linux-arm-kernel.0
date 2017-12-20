From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 20 Dec 2017 09:11:00 +0100
Subject: [PATCH v5 0/4] ARM: ep93xx: ts72xx: Add support for BK3 board
In-Reply-To: <20171219223612.1a67ba5b@jawa>
References: <20171116232239.16823-1-lukma@denx.de>
 <20171211233625.5689-1-lukma@denx.de>
 <CACRpkdbCeBCENDcRcYBKTXVNz6H3t=WKHYP8Uf3WJ=Wvtib1Jg@mail.gmail.com>
 <1513153607.2439.2.camel@Nokia-N900>
 <CAK8P3a2jEVQXKXJXp27ft5oaD8Jbo6g1fB-t_aduJWhC2dtJ0g@mail.gmail.com>
 <20171217204122.0a10a5e1@jawa>
 <CAK8P3a09V1ZhhVCvdy27BiBCMM54zo4qyypgSDvrg2CdpneVmg@mail.gmail.com>
 <20171217222856.2c5937a4@jawa>
 <CAK8P3a3VJapioU32oBtA2GDmvXiHvz3K=W6BGx+u=Tvb1aDXsg@mail.gmail.com>
 <1513598620.1538.2.camel@Nokia-N900> <20171219223612.1a67ba5b@jawa>
Message-ID: <CAK8P3a1W+jU79GriKLZ1SXoVLaxC+przqQUTyHH6zz8+9dw2jg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 19, 2017 at 10:36 PM, Lukasz Majewski <lukma@denx.de> wrote:
> Hi Arnd,
>
>> Hi!
>>
>> On Mon Dec 18 12:55:40 2017 Arnd Bergmann <arnd@arndb.de> wrote:
>> > > GCC 7.2 is working
>> >
>> > Ah wait, this is still for ep93xx, which is always at least armv4t,
>> > right? So it won't have a problem with the armv4 deprecation
>> > anyway, even
>>
>> Correct.
>
> Maybe a bit off topic :-)
>
> Are there any more comments regarding this patch series? Are those
> patches eligible for applying them to -next?

Alexander already sent a pull request, I just haven't pulled them. If there
are any other comments or additional patches, they should be done
on top of the first pull request, unless there is a major regression in
the original pull (which is unlikely).

        Arnd
