From: olof@lixom.net (Olof Johansson)
Date: Tue, 12 Jun 2018 07:15:29 -0700
Subject: [GIT PULL 2/4] ARM: Device-tree updates
In-Reply-To: <1628804.nlB6U0QxHY@phil>
References: <20180612000142.28883-1-olof@lixom.net>
 <20180612000142.28883-3-olof@lixom.net>
 <CA+55aFy2sOHqcO-6LaKOZ5omyAow15gq+=Z7aOTZisrDihoecw@mail.gmail.com>
 <1628804.nlB6U0QxHY@phil>
Message-ID: <CAOesGMghTquZgS2=M=wLNWNJrkWKBPdj-L=p6cY6n4kaqUmP_A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jun 12, 2018 at 6:04 AM, Heiko Stuebner <heiko@sntech.de> wrote:
> Am Dienstag, 12. Juni 2018, 03:04:34 CEST schrieb Linus Torvalds:
>> On Mon, Jun 11, 2018 at 5:02 PM Olof Johansson <olof@lixom.net> wrote:
>> >
>> > - Qualcomm:
>> > + SDM845, a.k.a Snapdragon 845, an 4+4-core Kryo 385/845
>> > (Cortex-A75/A55 derivative) SoC that's one of the current high-end
>> > mobile SoCs.
>> >
>> > It's great to see mainline support for it. So far, you
>> > can't do much with it, since a lot of peripherals are not yet in the
>> > DTs but driver support for USB, GPU and other pieces are starting to
>> > trickle in. This might end up being a well-supported SoC upstream if
>> > the momentum keeps up.
>>
>> Isn't the Qualcomm 845 also the SoC in some of the new WARM laptops?
>>
>> I asked one person that had an older one (ASUS NovaGo - Qualcomm 835),
>> and apparently you can actually disable secure boot on that thing and
>> boot from USB.
>>
>> In other words, it might _actually_ act like a normal laptop.
>>
>> I'd love to have something that is actually a real honest-to-goodness
>> ARM laptop finally. Are we getting at all close to that?
>
> I guess the Samsung Chromebook Plus (Rockchip RK3399-based [branded
> OP1 though]) also is somewhat close to that target - even with a nice
> high-res display and everything except the 32kb BootRom being replaceable.
>
> Of course Qualcomm-based devices have the Adreno/Freedreno bonus,
> but even in that area we're seeing some progress for Mali (Midgard)
> this year [0].

Yeah, I think the benefit of the Qualcomm platform is the graphics
situation upstream, and they also come with a (native) bootloader that
makes more sense for those not used to the embedded ways of booting.
Sigh, I really wish ARM would come to the table and start working with
upstream on their Mali drivers.

About 845; it looks like there's mostly announced products and none
are shipping yet, so most people with knowledge probably still need to
be tight-lipped about details. I do look forward to seeing some of
these products coming out and what people will do with them. The fact
that secure boot can be turned off on them through regular settings is
promising.


-Olof
