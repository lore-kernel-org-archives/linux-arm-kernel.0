From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 31 Mar 2015 11:00:31 +0200
Subject: [rtc-linux] Re: [PATCH 1/2] drivers/rtc/rtc-s3c.c: Integrate
 Exynos3250 into S3C6410
In-Reply-To: <20150331082052.GI3849@piout.net>
References: <1427728773-29065-1-git-send-email-k.kozlowski@samsung.com>
 <1427728773-29065-2-git-send-email-k.kozlowski@samsung.com>
 <20150331002709.GF3849@piout.net>
 <CABxcv==+h8R-tL9D5OXmYsuYfs_cLATViZ3N1veZwZBZF=fu0Q@mail.gmail.com>
 <20150331082052.GI3849@piout.net>
Message-ID: <CAJKOXPemefBOfOUV_azuJbiOMGurZLTGtFKBx7rW6NCgu+sjvQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-03-31 10:20 GMT+02:00 Alexandre Belloni
<alexandre.belloni@free-electrons.com>:
> Hi,
>
> On 31/03/2015 at 08:49:39 +0200, Javier Martinez Canillas wrote :
>> Hello Alexandre,
>>
>> On Tue, Mar 31, 2015 at 2:27 AM, Alexandre Belloni
>> <alexandre.belloni@free-electrons.com> wrote:
>> > nitpick: I would prefer rtc: rtc-s3c instead of drivers/rtc/rtc-s3c.c
>> >
>>
>> Yes but Krzysztof is following the convention used in drivers/rtc/
>> which I think is the correct thing to do even when it's different from
>> what is used all over the kernel.
>>
>
> Having a look at the git history, the first and most used prefix is
> actually 'rtc:' at some point, this started to change to 'drivers/rtc/'.
> We should probably start to get back to 'rtc:', like most subsystems.

Yes, I used "rtc: driver_name:" before but I saw that Andrew changes
them to full path when he picks the patch. So this time I wanted to
reduce the overhead for him... Anyway I'll stick to one format ("rtc:
rtc-s3c:") as you proposed.

Best regards,
Krzysztof
