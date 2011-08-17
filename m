From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 17 Aug 2011 10:53:15 +0200
Subject: [PATCH 10/19] mach-ep93xx: break out GPIO driver specifics
In-Reply-To: <ADE657CA350FB648AAC2C43247A983F001F3883899A6@AUSP01VMBX24.collaborationhost.net>
References: <1312978655-18405-1-git-send-email-linus.walleij@stericsson.com>
	<ADE657CA350FB648AAC2C43247A983F001F38838966E@AUSP01VMBX24.collaborationhost.net>
	<CACRpkdabHj_C7wgGfu3g6LSsa2iMZS0h279wf6McOxfge9Gm_w@mail.gmail.com>
	<ADE657CA350FB648AAC2C43247A983F001F388389983@AUSP01VMBX24.collaborationhost.net>
	<ADE657CA350FB648AAC2C43247A983F001F3883899A6@AUSP01VMBX24.collaborationhost.net>
Message-ID: <CACRpkdYDsBRew0WpR1655k4+7BpUomOCEVyrH-Or88WJ4MjzJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 11, 2011 at 7:48 PM, H Hartley Sweeten
<hartleys@visionengravers.com> wrote:
> On Thursday, August 11, 2011 10:16 AM, H Hartley Sweeten wrote:

>> The other solution is to hook up the gpiolib to_irq callback in
>> gpio-ep93xx and do:
>>
>> #define gpio_to_irq ? __gpio_to_irq
>>
>> Maybe this is a better option?
>
> BTW, I have a patch for this if you want.

Thanks! I'm fixing up this patchset so will include this one
and rebase on top of it.

Yours,
Linus Walleij
