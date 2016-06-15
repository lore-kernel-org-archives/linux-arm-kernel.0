From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 15 Jun 2016 15:37:32 +0200
Subject: [PATCH 5/5] ARM: dts: add Qualcomm APQ8060-based Dragonboard
In-Reply-To: <20160614191154.GK28218@codeaurora.org>
References: <1465918259-11138-1-git-send-email-linus.walleij@linaro.org>
 <1465918259-11138-6-git-send-email-linus.walleij@linaro.org>
 <20160614191154.GK28218@codeaurora.org>
Message-ID: <CACRpkdYL9e1Oi7mbm6SCjbtB2W-EGQPGiw-4JWfhg-022hoveA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 14, 2016 at 9:11 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:

>> +/* Intenal 3.69 GiB eMMC */
>> +&sdcc1 {
>> +     status = "okay";
>> +     pinctrl-names = "default";
>> +     pinctrl-0 = <&dragon_sdcc1_pins>;
>> +     vmmc-supply = <&pm8901_l5>;
>> +     vqmmc-supply = <&pm8901_lvs0>;
>> +};
>
> I think we're following a non-phandle approach to filling out
> board dts files. We didn't follow it that well on 8660 surf,
> probably because it was so basic, but it would be nice to follow
> that style here as well and populate board properties in nodes
> like how gsbi at 19c00000 has been done. I'll leave this up to Andy
> though as he's the maintainer here.

Andy? How do you want it? I can do it either way, no big deal for
me.

Yours,
Linus Walleij
