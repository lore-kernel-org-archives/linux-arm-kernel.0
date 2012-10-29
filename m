From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Mon, 29 Oct 2012 13:26:06 +0300
Subject: [PATCH 2/5] ARM: PXA: Zipit Z2: Add USB host and device support
In-Reply-To: <201210291122.25510.marex@denx.de>
References: <1351438555-4668-1-git-send-email-anarsoul@gmail.com>
 <508E4F7F.7010607@gmail.com>
 <CA+E=qVcnacT8L5GkqTxdowKt2KkoEWMhd3+XBk6nKsEEDtWecg@mail.gmail.com>
 <201210291122.25510.marex@denx.de>
Message-ID: <CA+E=qVc1zbV8bQKinPZv2gEAUuiAWyqVF0gbvd_iidGdPPdOGw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 29, 2012 at 1:22 PM, Marek Vasut <marex@denx.de> wrote:
>
> Uh, you already have that. U-Boot can boot kernel and pass DT properly, just use
> latest 2012.10 release which just got out a few weeks ago.

It still lacks pxa27x keypad support, same for fb rotation :) So I
need to port some older patches

>> > Some parts like the uart, host-mode usb, mmc, gpio-leds, gpio-keys, i2c
>> > etc are already finished and should work instantly. What's missing is
>> > the spi controller and the display, but maybe you can help getting these
>> > done?
>>
>> What about libertas? I still don't understand how DT handles
>> platform-specific callbacks like set_power(). And what about pm_power_off
>> hook?
>
> Start small, platform crap and DT goo can co-exist for a while.

OK

> Best regards,
> Marek Vasut

Regards
Vasily
