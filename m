From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 23 Sep 2015 16:46:31 +0200
Subject: [PATCH v2 0/7] New Atmel PIO4 pinctrl/gpio driver
In-Reply-To: <CACRpkdYLbifY9VJK0FFf7xXdMJWstdGP=h5ApBMRyRXZHPDUaw@mail.gmail.com>
References: <1442417823-15850-1-git-send-email-ludovic.desroches@atmel.com>
 <CACRpkdYLbifY9VJK0FFf7xXdMJWstdGP=h5ApBMRyRXZHPDUaw@mail.gmail.com>
Message-ID: <5602BB47.4040401@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 21/09/2015 20:50, Linus Walleij a ?crit :
> On Wed, Sep 16, 2015 at 8:36 AM, Ludovic Desroches
> <ludovic.desroches@atmel.com> wrote:
> 
>> The Atmel PIO4 controller has been introduced with SAMA5D2 chip family. This
>> drivers manages both pinmux/pinconf and gpio stuff. It is inspired by Mediatek
>> pinctrl driver.
>>
>> Changes from v1:
>> - remove some unneeded gpio specific ops (gpio_request, gpio_free,
>>   gpio_request_enable, gpio_disable_free and gpio_set_direction).
>> - code styling fixes.
>> - add sama5d2 pin description and device pin muxing.
> 
> Looks Good To Me, and has Sascha's ACKs, so merged patches
> 1, 2, 3, 4 to the pinctrl tree. Please merge the AT91 DT things into
> the AT91 tree.

Great!

So patch 5 is included in at91-4.4-defconfig branch.
patches 6 and 7 queued in at91-4.4-dt branch.
They are included in at91-next that is merged in linux-next and will
both take the arm-soc path later in the cycle.

Thanks, bye,
-- 
Nicolas Ferre
