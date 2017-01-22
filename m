From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 22 Jan 2017 23:44:27 +0100
Subject: [PATCH 00/22] Conversion of ARMv4 Gemini to DT and multiplatform
In-Reply-To: <8e705d3a-ff99-23b2-c4c9-2edccf134cac@gmail.com>
References: <20170122121506.9995-1-linus.walleij@linaro.org>
 <8e705d3a-ff99-23b2-c4c9-2edccf134cac@gmail.com>
Message-ID: <CACRpkdbdsNU6pOcewyZw_jpXzXvm_aj0FURY7Ty5FkT227iZ=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 22, 2017 at 7:42 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> On 01/22/2017 04:15 AM, Linus Walleij wrote:
>> I got a Gemini platform from Florian Fainelli over at OpenWRT
>> some time back. I finally got around to "future-proofing" the
>> platform, which was the idea when he paintakingly sent the box
>> over to me.
>
> I would have happily tested that series ;) thanks a lot for making it
> happen!

There is a git branch here:
https://git.kernel.org/cgit/linux/kernel/git/linusw/linux-nomadik.git/log/?h=gemini

I collect info and instructions to get it running here:
https://dflund.se/~triad/krad/gemini/

>> The OpenWRT tree still have a whole bunch of significant out-of
>> tree drivers:
>>
>> - Watchdog
>> - GMAC (ethernet)
>
> Been wondering about the GMAC driver a little bit, and it does not
> appear to be neither a Synopsys/Designware core (although not 100%
> sure), nor the ftgmac100 either.
>
> This submission does appear to be in a good shape:
> https://lwn.net/Articles/437889/

Hm what makes people stop submissions like that in mid-air?
Maybe we can shape it up and resend on top of the device tree
baseline.

Yours,
Linus Walleij
