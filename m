From: HartleyS@visionengravers.com (Hartley Sweeten)
Date: Tue, 16 Jun 2015 16:37:39 +0000
Subject: [PATCH 0/5] EP93xx GENERIC_CLOCKEVENTS
In-Reply-To: <CACRpkdbwpfHeiESZ9c71m5GV7VMGO3e0ky13mdEZMQ=8vpM0BQ@mail.gmail.com>
References: <1434376222-4587-1-git-send-email-linus.walleij@linaro.org>
 <DC148C5AA1CEBA4E87973D432B1C2D883D49CA16@P3PWEX4MB008.ex4.secureserver.net>
 <CACRpkdbwpfHeiESZ9c71m5GV7VMGO3e0ky13mdEZMQ=8vpM0BQ@mail.gmail.com>
Message-ID: <DC148C5AA1CEBA4E87973D432B1C2D883D4A35CE@P3PWEX4MB008.ex4.secureserver.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, June 16, 2015 12:04 AM, Linus Walleij wrote:
> On Mon, Jun 15, 2015 at 7:25 PM, Hartley Sweeten <HartleyS@visionengravers.com> wrote:
>> Tested on Vision Engraving Systems EP9307 (vision_ep9307.c).
>>
>> You can use whatever tag is appropriate:
>>
>> Tested-by: H Hartley Sweeten <hsweeten@visionengravers.com>
>> Reviewed-by: H Hartley Sweeten <hsweeten@visionengravers.com>
>
> Awesome.
>
> Do you want to queue this material for v4.3, or shall I create a branch
> to funnel this to ARM SoC? I will put your PATCH_PHYS_TO_VIRT
> patch on top of that pile of course.

If you can queue up any ep93xx patches that would be great.

Ryan used to queue them on his github branch but it has not been updated
for quite a while. I have not seen any responses from him lately so I'm not
sure if he is even active.

>> One nit...
>>
>> Is the "Timer handling for EP93xx" comment still correct?
>>
>> It still mentions a 16-bit timer (timer 1) used for the timer interrupt and gettimeoffset()
>> being used with timer 4.
>
> Darn, sent a separate patch to address this.

Great.

Thanks,
Hartley
