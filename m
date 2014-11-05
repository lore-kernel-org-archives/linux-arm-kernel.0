From: olof@lixom.net (Olof Johansson)
Date: Wed, 5 Nov 2014 11:00:06 -0800
Subject: [PATCH] ARM: dts: vf610: add SD node to cosmic dts
In-Reply-To: <566a5b330f05c69ad27902ca8ce24463@agner.ch>
References: <1415170765-3343-1-git-send-email-olof@lixom.net>
 <566a5b330f05c69ad27902ca8ce24463@agner.ch>
Message-ID: <CAOesGMjyWyPS-h9xB-MAN8A37PCN6dpqcMQ61yriu6-AZAqvZw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 5, 2014 at 12:40 AM, Stefan Agner <stefan@agner.ch> wrote:
> Am 2014-11-05 07:59, schrieb Olof Johansson:
>> Driver has been there since a while back, but the dts never seems to
>> have been updated with the node (nor pinctrl). Do so now.
>>
>> Cc: Matt Porter <mporter@linaro.org>
>> Signed-off-by: Olof Johansson <olof@lixom.net>
>> ---
>>
>> Shawn, Stefan: This probably has some small conflicts with Stefan's
>> patchsets that refactors some of the dts contents for 3.19. I'd like to
>> pick this patch up as a fix for 3.18 though, since it makes my Cosmic+
>> board usable for the boot farm.
>>
>> If that'd be OK (i.e. to apply Stefan's patches on top of this), please
>> ack so I can include it with the next set of fixes. :)
>>
>> Thanks,
>>
>> -Olof
>
> Same reordering complains as Shawn.
>
> Also note that starting with 3.19, it would be possible to use card
> detect GPIO. However, SD-card works also fairly well without card
> detection.
>
> Acked-by: Stefan Agner <stefan@agner.ch>

Thanks, reordered entries (d'oh!) and applied to fixes with your acks.

CD gpio would be useful, in my case I always have the card attached
though. I'll try to remember revisiting for that. :-)


-Olof
