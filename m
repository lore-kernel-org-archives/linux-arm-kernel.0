From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 29 May 2013 20:41:26 +0200
Subject: [PATCH 7/7] Documentation: Update binding for Nomadik and DBx5x
 based platforms
In-Reply-To: <20130528093815.GH22683@gmail.com>
References: <1369232581-18923-1-git-send-email-lee.jones@linaro.org>
 <1369232581-18923-8-git-send-email-lee.jones@linaro.org>
 <CACRpkdYyZZSy4VgFc+Uo=5iAF++EPmHM0U2pHcLdkDZc=Xb_sQ@mail.gmail.com>
 <20130528093815.GH22683@gmail.com>
Message-ID: <CACRpkdYyZuReZEJCO6h8Ez3=7AmOm=JdT0_Gd+hDaGFnNJ8cGw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 28, 2013 at 11:38 AM, Lee Jones <lee.jones@linaro.org> wrote:
>> >  Required properties:
>> > -- compatible: "stericsson,nmk-pinctrl", "stericsson,nmk-pinctrl-db8540",
>> > -              "stericsson,nmk-pinctrl-stn8815"
>> > +- compatible: "stericsson,db8500-pinctrl", "stericsson,db8540-pinctrl",
>> > +              "stericsson,stn8815-pinctrl"
>>
>> OK...
>>
>> >         pinctrl at 80157000 {
>> > -               compatible = "stericsson,nmk-pinctrl";
>> > +               compatible = "stericsson,u8500-pinctrl";
>>
>> This does not look like a supported compatible string?
>
> Do you still think this, or did you change you mind?

Que? It is not among the listed compatible strings?

> If so, what makes you think it? How does it differ from:
>
> compatible = "arm,cortex-a9-twd-timer";
> compatible = "arm,rtc-pl031";
> compatible = "stericsson,db8500-gpio",
> compatible = "stericsson,db8500-musb",
> compatible = "stericsson,db8500-dma40",
> compatible = "stericsson,db8500-prcmu";
> compatible = "stericsson,db8500-prcmu-timer-4";
> compatible = "stericsson,db8500-thermal";
> compatible = "stericsson,db8500-prcmu-regulator";

It says u8500-pinctrl, not db8500-pinctrl.

Could it be that you're not actually seeing your own typo?

Yours,
Linus Walleij
