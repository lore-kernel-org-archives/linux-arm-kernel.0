From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 12 Jun 2012 09:03:18 +0100
Subject: [PATCH 14/14] ARM: ux500: Move rtc-pl031 registration to Device
 Tree when enabled
In-Reply-To: <CACRpkdbJdA8rgcXX4Xc3sMrx==5jd-Scu1Xy0UKz0ot3_bbNzw@mail.gmail.com>
References: <1339428307-3850-1-git-send-email-lee.jones@linaro.org>
 <1339428307-3850-15-git-send-email-lee.jones@linaro.org>
 <CACRpkdbJdA8rgcXX4Xc3sMrx==5jd-Scu1Xy0UKz0ot3_bbNzw@mail.gmail.com>
Message-ID: <4FD6F7C6.80002@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/06/12 22:43, Linus Walleij wrote:
> On Mon, Jun 11, 2012 at 5:25 PM, Lee Jones<lee.jones@linaro.org>  wrote:
>
>> During a Device Tree boot, all probing will now be completed on parse
>> of the Device Tree binary. In the same patch we remove platform
>> registration of the Real Time Clock.
>>
>> Signed-off-by: Lee Jones<lee.jones@linaro.org>
>
> Oh this is a bug fix really, well it's in the device tree so nevermind.

It is? How so?

> Acked-by: Linus Walleij<linus.walleij@linaro.org>
>
> Yours,
> Linus Walleij


-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
