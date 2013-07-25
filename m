From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 25 Jul 2013 16:01:22 +0200
Subject: [PATCH 2/2] clk: fixup argument order when setting VCO parameters
In-Reply-To: <51F0F199.3040501@arm.com>
References: <1374594138-17080-1-git-send-email-jonathan.austin@arm.com>
 <1374594138-17080-3-git-send-email-jonathan.austin@arm.com>
 <CACRpkdbEiNPG0b89zXKpvNgXtAbsKeV9A9ibgEJCBgNa6vQvCw@mail.gmail.com>
 <51F0F035.8010705@arm.com>
 <CACRpkdb7UGS8ysPv=LakbWouUdL9MpKvrgYKh_v9NqSYV3TStg@mail.gmail.com>
 <51F0F199.3040501@arm.com>
Message-ID: <CACRpkdbMxdzpjQrEkSxX-NZKVRNFVT44NDhuZ4pdua5Prvjmug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 25, 2013 at 11:36 AM, Jonathan Austin
<jonathan.austin@arm.com> wrote:
> On 25/07/13 10:33, Linus Walleij wrote:

>> Then as the VCO params get written, it is never really unlocked
>> so the registers are untouched.
>>
>> You may have a different boot monitor?
>>
>
> Ahh, that seems highly likely. I don't ever see boot-monitor (boot straight
> in to uboot) but I don't see anything on the display until the kernel boots,
> so I don't think BM is setting up the VCO for me.

True, if you boot directly into U-boot the boot monitor is
never executed and the mode is never set up.

Yours,
Linus Walleij
