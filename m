From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 22 Mar 2017 12:42:04 +0100
Subject: [PATCH 1/6] pinctrl: dt-bindings: Add documentation for Armada
 37xx pin controllers
In-Reply-To: <CACRpkdY_yUpo1nkbr0T-FZVSRFynuLSZ_6etho0hHk+otaUiYw@mail.gmail.com>
 (Linus Walleij's message of "Fri, 30 Dec 2016 09:35:27 +0100")
References: <20161222172501.16121-1-gregory.clement@free-electrons.com>
 <20161222172501.16121-2-gregory.clement@free-electrons.com>
 <CACRpkdY_yUpo1nkbr0T-FZVSRFynuLSZ_6etho0hHk+otaUiYw@mail.gmail.com>
Message-ID: <87d1d9fshf.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,
 
 On ven., d?c. 30 2016, Linus Walleij <linus.walleij@linaro.org> wrote:

> On Thu, Dec 22, 2016 at 6:24 PM, Gregory CLEMENT
> <gregory.clement@free-electrons.com> wrote:
>
>> Document the device tree binding for the pin controllers found on the
>> Armada 37xx SoCs.
>>
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> (...)
>
>> +Required properties for pinctrl driver:
>> +- compatible:  "marvell,armada3710-sb-pinctrl" for the south bridge
>> +               "marvell,armada3710-nb-pinctrl" for the north bridge
>> +- reg: The first set of register are for pinctrl/gpio and the second
>> +  set for the interrupt controller
>> +- interrupts: list of the interrupt use by the gpio
>
> While this makes sense on its own, it doesn't match the code you sent.
>
> The code uses syscon and regmap inside a simple-mfd node, not reg.
>
> Please clarify how this works so we can see what is going on.
>
> The syscon part doesn't seem optional at all.

OK done.

>
> Yours,
> Linus Walleij

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
