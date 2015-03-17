From: eliad@wizery.com (Eliad Peller)
Date: Tue, 17 Mar 2015 09:02:33 +0200
Subject: [PATCH v6 5/6] ARM: dts: add wl12xx/wl18xx bindings
In-Reply-To: <CAN692hmTGDDB3W5TtgfmQK5V9hUGpqVHpF=xK7F_v85cUjcRPw@mail.gmail.com>
References: <1426162154-8716-1-git-send-email-eliad@wizery.com>
 <1426162154-8716-6-git-send-email-eliad@wizery.com>
 <CABxcv=mETO9ESVa04YjRO1d-h5ksEwvwGKb1G-jxVk6ttr9JYg@mail.gmail.com>
 <CAFqH_53D52WGDZUTv=w7SguTeROwrzmn9XLB+cTg-3y+Q4FxfQ@mail.gmail.com>
 <CAN692hmTGDDB3W5TtgfmQK5V9hUGpqVHpF=xK7F_v85cUjcRPw@mail.gmail.com>
Message-ID: <CAB3XZEeqKy2Zox0wvZmc-pJjCRzBcAXRFj2TjD=WGZjvnFuAqg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

that would be great. thanks.
i'll try posting the updated patchset (v7, some minor changes) tomorrow.

Eliad.

On Mon, Mar 16, 2015 at 3:08 PM, Pau Pajuel <paupa13@gmail.com> wrote:
> Hi,
>
> 2015-03-13 9:17 GMT+01:00 Enric Balletbo Serra <eballetbo@gmail.com>:
>>
>> Hello,
>>
>> 2015-03-13 9:01 GMT+01:00 Javier Martinez Canillas <javier@dowhile0.org>:
>> > Hello Eliad,
>> >
>> > On Thu, Mar 12, 2015 at 1:09 PM, Eliad Peller <eliad@wizery.com> wrote:
>> >> Replace all the pdata-quirks for setting wl12xx/wl18xx
>> >> platform data with proper DT definitions.
>> >>
>> >> The patch was compile-tested only.
>> >>
>> >> Signed-off-by: Eliad Peller <eliad@wizery.com>
>> >> ---
>> >
>> > I wanted to test your series but I realized that the IGEPv2 I've
>> > access is the old revision that has another SDIO wlan module instead
>> > of a Wilink8.
>> >
>> > Maybe Enric have the new revision? I also added to Pau Pajuel as cc
>> > who still works in the company manufacturing these boards so he should
>> > be able to test it.
>> >
>>
>> Sorry, now I only have an old revision too, so I can't test, cc'ing
>> Agust? that has access to the hardware, maybe he can test it or he can
>> provide to us a board ;)
>>
>> > But in any case, your patch looks good to me so for the
>> > arch/arm/boot/dts/omap3-igep00* changes:
>> >
>> > Acked-by: Javier Martinez Canillas <javier@dowhile0.org>
>> >
>>
>> For my part also looks good.
>>
>> Acked-by: Enric Balletbo i Serra <eballetbo@gmail.com>
>>
>> Best regards,
>>    Enric
>>
>> > Best regards,
>> > Javier
>
>
> I'm gonna test it this week. I added Eduard Gavin as cc too.
>
> Cheers!
