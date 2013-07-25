From: jonathan.austin@arm.com (Jonathan Austin)
Date: Thu, 25 Jul 2013 10:36:25 +0100
Subject: [PATCH 2/2] clk: fixup argument order when setting VCO parameters
In-Reply-To: <CACRpkdb7UGS8ysPv=LakbWouUdL9MpKvrgYKh_v9NqSYV3TStg@mail.gmail.com>
References: <1374594138-17080-1-git-send-email-jonathan.austin@arm.com>
 <1374594138-17080-3-git-send-email-jonathan.austin@arm.com>
 <CACRpkdbEiNPG0b89zXKpvNgXtAbsKeV9A9ibgEJCBgNa6vQvCw@mail.gmail.com>
 <51F0F035.8010705@arm.com>
 <CACRpkdb7UGS8ysPv=LakbWouUdL9MpKvrgYKh_v9NqSYV3TStg@mail.gmail.com>
Message-ID: <51F0F199.3040501@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/07/13 10:33, Linus Walleij wrote:
> On Thu, Jul 25, 2013 at 11:30 AM, Jonathan Austin
> <jonathan.austin@arm.com> wrote:
>
>>> What I don't understand is why my CLCD VGA output has
>>> been working all the time :-(
>>>
>>
>> No, this confuses me too - perhaps the display you've got it plugged in to
>> is really lenient about modes and just made the best of it?
>
> I think it's because it is set up into some mode by the boot
> monitor, as I get the boot monitor prompt on the VGA
> display.
>
> Then as the VCO params get written, it is never really unlocked
> so the registers are untouched.
>
> You may have a different boot monitor?
>

Ahh, that seems highly likely. I don't ever see boot-monitor (boot 
straight in to uboot) but I don't see anything on the display until the 
kernel boots, so I don't think BM is setting up the VCO for me.

Jonny
