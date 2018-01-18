From: eric@anholt.net (Eric Anholt)
Date: Thu, 18 Jan 2018 12:50:55 -0800
Subject: [PATCH v2 1/4] ARM: bcm2835: sync firmware properties with
 downstream
In-Reply-To: <632b9d56-78cf-1e8e-8cd2-30edd2de70c0@i2se.com>
References: <cover.1515698418.git.baruch@tkos.co.il>
 <e68675d54955c754ebe8ffc2491585fde5b396bc.1515698418.git.baruch@tkos.co.il>
 <1991337128.42939.1515837465503@email.1und1.de>
 <CACRpkdZ_g3-jR-7pOnS9MwpHprfEz8acB9SWcMLyoOVcB0iLvA@mail.gmail.com>
 <20180116104904.fsebsozoa4xysbz7@tarshish>
 <632b9d56-78cf-1e8e-8cd2-30edd2de70c0@i2se.com>
Message-ID: <87vafy7uxc.fsf@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stefan Wahren <stefan.wahren@i2se.com> writes:

> Hi Baruch,
>
> Am 16.01.2018 um 11:49 schrieb Baruch Siach:
>> Hi Linus,
>>
>> On Tue, Jan 16, 2018 at 10:57:32AM +0100, Linus Walleij wrote:
>>> On Sat, Jan 13, 2018 at 10:57 AM, Stefan Wahren <stefan.wahren@i2se.com> wrote:
>>>>> Baruch Siach <baruch@tkos.co.il> hat am 11. Januar 2018 um 20:44 geschrieben:
>>>>>
>>>>> Add latest firmware property tags from the latest Raspberry Pi downstream
>>>>> kernel. This is needed for the GPIO tags, so we can control the GPIO
>>>>> multiplexor lines.
>>>>>
>>>>> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
>>>> Acked-by: Stefan Wahren <stefan.wahren@i2se.com>
>>>>
>>>> Maybe this is obvious, but patch #3 depends on this change so no cherry-picking allowed.
>>> I will save this for after the merge window as it feels now.
>>>
>>> But as far as I have the right ACKs I can put it in the GPIO tree.
>>>
>>> Baruch: can you resend the series with all ACKs and push me
>>> to apply it all in the GPIO tree if you're fine with this approach?
>> I plan to send another revision of this series later today to address Stefan's
>> comments on this one. Once Stefan and/or Eric ack the entire series, I'm fine
>> with you taking it through the GPIO tree if it is OK with the BCM2835
>> maintainers.
>>
>> baruch
>>
>
> we also need an ACK from the devicetree maintainers. So please send a 
> copy of the binding patch V3 to Rob Herring and Marc Rutland.

I'll be happy to see patch 1-3 go through the GPIO tree, and we'd take
#4 in the 2835 tree.  The only risk I see is if we need patch 1 for some
other change in this cycle -- seems unlikely, but if Linus applied the
series starting from a rc1 tag and merged it in, then we'll also be able
to merge that patch over to any other branch we need without duplicating
it in git history.

Once you get this resent with the DT folks Cced, hopefully it'll be
pretty quick.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180118/b094e1b4/attachment.sig>
