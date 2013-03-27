From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 27 Mar 2013 21:03:03 +0100
Subject: [PATCH 4/6] pinctrl: sunxi: add clock support
In-Reply-To: <CACRpkdbn9c_bAWUN8hTLkeidCnyZ=0nRQRBV39DMkK_0jBfoUQ@mail.gmail.com>
References: <1363962042-29536-1-git-send-email-emilio@elopez.com.ar>
 <1363962042-29536-5-git-send-email-emilio@elopez.com.ar>
 <CACRpkdbn9c_bAWUN8hTLkeidCnyZ=0nRQRBV39DMkK_0jBfoUQ@mail.gmail.com>
Message-ID: <51535077.1050203@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Le 27/03/2013 14:14, Linus Walleij a ?crit :
> On Fri, Mar 22, 2013 at 3:20 PM, Emilio L?pez <emilio@elopez.com.ar> wrote:
> 
>> For the port controller to work, we need to enable the apb0_pio gate.
>> This commit adds the ability to enable one clock specified on the device
>> tree to the pinctrl driver.
>>
>> Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> I guess you'll want to merge these as one series to some platform-specific
> tree, tell me if you want it merged in the pinctrl tree.

The easiest would probably be to merge this patch through your patch,
with Mike taking the clock driver patches and me taking the dt ones,
once we agree on the other patches.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
