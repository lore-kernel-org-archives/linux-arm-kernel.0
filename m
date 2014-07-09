From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Wed, 9 Jul 2014 12:14:44 +0200
Subject: [PATCH 2/3] ARM: dts: Update the parent for Audss clocks in
 Exynos5420
In-Reply-To: <53BB5EBD.5030607@gmail.com>
References: <1402464739-19044-1-git-send-email-tushar.b@samsung.com>
 <1402464739-19044-3-git-send-email-tushar.b@samsung.com>
 <CAD=FV=W5yh58fYTwRZxmZt=BORcZMSRV0oRe12yA74Q5h2S4YQ@mail.gmail.com>
 <7hpphwlgn0.fsf@paris.lan>
 <CAC5m3Bzey-YoPLmjAq4YNPQ13rojtVFWAbnhX6-ZFtYZwEdMWg@mail.gmail.com>
 <7h8uojk61a.fsf@paris.lan> <53ACE724.7090606@gmail.com>
 <CAGa+x86COQz+cYtrXWrP-sjFGz-gi2tf6GEvLiKYoQwg1zMivQ@mail.gmail.com>
 <CAGa+x87LHiYGb03=GRcZisK1=TyakW1htd1E2vOQ6ijZKw8syg@mail.gmail.com>
 <53B2A2A5.4070203@gmail.com> <53BB2E7A.5080204@samsung.com>
 <53BB5EBD.5030607@gmail.com>
Message-ID: <CABxcv=ka5UxZ8E3+F4cR4vcY1m3AfX=g7HiaNYqmyQjHfSVqtw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Tushar,

On Tue, Jul 8, 2014 at 5:00 AM, Tushar Behera <trblinux@gmail.com> wrote:
>>>
>>> The u-boot version is a little different on my Peach-Pi as compared to
>>> the market release version. Not sure if that is making any difference.
>>>
>>> Peach # version
>>>
>>> U-Boot 2013.04 (Feb 13 2014 - 16:35:03) for Peach
>>> armv7a-cros-linux-gnueabi-gcc.real (4.8.1_cos_gg_feea904_4.8.1-r66)
>>> 4.8.x-google 20130905 (prerelease)
>>> GNU ld (binutils-2.22_cos_gg_2) 2.22
>>>
>>

I'm using the same U-Boot version than Kevin (U-Boot 2013.04-gb98ed09)
and on my setup using chained nv-uboot I also need patch 1/3 along
with 2/3 to fix the issue.

>> Note that I've applied this only from this series so I'm not sure how
>> much the problem can be solved...any updates for 1/3 and 3/3?
>>
>> - Kukjin
>
> Thanks for applying 2/3. I am working on 1/3 to see if we are following
> the right approach to fix Kevin's issue (unfortunately, I am not hitting
> the bug on my board ATM). 3/3 has already been merged through a
> different patchset.
>

I'm sending as an attachment my complete boot log when booting today's
next (20140709) until it hangs and my u-boot env vars. I hope that
helps.

> --
> Tushar Behera
> --

Best regards,
Javier
-------------- next part --------------
A non-text attachment was scrubbed...
Name: boot_log
Type: application/octet-stream
Size: 16442 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140709/8d6422b3/attachment-0002.obj>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: uboot_env
Type: application/octet-stream
Size: 3614 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140709/8d6422b3/attachment-0003.obj>
