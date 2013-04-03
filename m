From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 3 Apr 2013 13:59:54 +0200
Subject: [PATCH 4/6] pinctrl: sunxi: add clock support
In-Reply-To: <51535077.1050203@free-electrons.com>
References: <1363962042-29536-1-git-send-email-emilio@elopez.com.ar>
 <1363962042-29536-5-git-send-email-emilio@elopez.com.ar>
 <CACRpkdbn9c_bAWUN8hTLkeidCnyZ=0nRQRBV39DMkK_0jBfoUQ@mail.gmail.com>
 <51535077.1050203@free-electrons.com>
Message-ID: <CACRpkda80EKT2LbsBCOng=gkdtdd+vbYwkMPiFZUBx7z_aqY+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 27, 2013 at 9:03 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:

> Hi Linus,
> Le 27/03/2013 14:14, Linus Walleij a ?crit :
>> On Fri, Mar 22, 2013 at 3:20 PM, Emilio L?pez <emilio@elopez.com.ar> wrote:
>>
>>> For the port controller to work, we need to enable the apb0_pio gate.
>>> This commit adds the ability to enable one clock specified on the device
>>> tree to the pinctrl driver.
>>>
>>> Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
>>
>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>>
>> I guess you'll want to merge these as one series to some platform-specific
>> tree, tell me if you want it merged in the pinctrl tree.
>
> The easiest would probably be to merge this patch through your patch,
> with Mike taking the clock driver patches and me taking the dt ones,
> once we agree on the other patches.

OK then, patch applied to the pinctrl tree, thanks!

Yours,
Linus Walleij
