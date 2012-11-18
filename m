From: csd_b@daudt.org (Christian Daudt)
Date: Sat, 17 Nov 2012 16:02:41 -0800
Subject: [PATCH V3] Add support for generic BCM SoC chipsets
In-Reply-To: <CAA-5wcAyyh5VRySrNe5Efzbwb9n_4fDxHV4Jzz79H17NUHBtjA@mail.gmail.com>
References: <1352843517-31328-1-git-send-email-csd@broadcom.com>
 <201211171721.15021.arnd@arndb.de>
 <CAA-5wcAqcjA7VNVXRZ8AE2r5EFQsFa68Rqi_ptYDDR9XXHsUMg@mail.gmail.com>
 <201211171804.50705.arnd@arndb.de>
 <CAA-5wcAyyh5VRySrNe5Efzbwb9n_4fDxHV4Jzz79H17NUHBtjA@mail.gmail.com>
Message-ID: <CAGFynZ-C4ZZiBMT6rff0U7kBZ55qZD7wMar7mDs9mu5f0v6BRA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 17, 2012 at 3:39 PM, Christian Daudt <cdaudt@gmail.com> wrote:
>
>
> On Sat, Nov 17, 2012 at 10:04 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> On Saturday 17 November 2012, Christian Daudt wrote:
>> > > At that point doesn't the 'oldest part' become the wildcard  ? I'm not
>> > very attached to names, so I'm ok changing bcm281xx above to bcm11351,
>> > which happens to be the first chip I'm submitting a board for. But then
>> > bcm11351 will just become 'the chip name used to represent the family'
>> > right ? I had followed the fact that omap does use omap5 in omap5.dtsi -
>> > and afaik tegra2 and tegra3 are family names, not chip models, and are
>> > used
>> > in dtsi. But then again a bunch of chip models are used to represent the
>> > families too...
>> >  Let me know if you want me to submit a modified patchset. Shouldn't
>> > take
>> > me more than 5 minutes anyways :)
>>
>> I think in a lot of cases, we just list all the possible parts
>> specifically
>> since we already know them, especially when supporting a new one requires
>> changing code already.
>>
>> Using bcm11351 as the name for the family sounds reasonable to me when
>> the other ones are derived from that, and the other option is to just
>> list all the ones that are out there already in the source code match
>> table. For future SoCs, you can then decide whether you want to change
>> the code to add the new number or just list one of the existing parts
>> as backwards compatible for the new device tree file if that allows
>> you to support it without other code changes.
>>
>> Please pick one of the two options and resubmit.
>
> ok. resubmitting shortly with bcm11351.
>

On an administrative question: Stephen sent me a reviewed-by that
effectively applied to V4 of the patch. I dropped it for V5 as this is
not the exact patchset that he reviewed. Is the expected procedure
that new versions of patches carry previous reviewed-by or not ? I
could not find any reference to that in the submittingpatches doc

 thanks,
   csd
