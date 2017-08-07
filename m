From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 7 Aug 2017 14:12:04 +0200
Subject: [PATCH v2 2/3] gpio: davinci: Handle the return value of
 davinci_gpio_irq_setup function
In-Reply-To: <32ca2ace-bca3-4819-d3fb-10331cd0213c@ti.com>
References: <1500543738-9696-1-git-send-email-j-keerthy@ti.com>
 <1500543738-9696-3-git-send-email-j-keerthy@ti.com>
 <32ca2ace-bca3-4819-d3fb-10331cd0213c@ti.com>
Message-ID: <CACRpkdanDK338_eEKpekD39MedJKbCkFMtLbGske3QpTQKv28g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 2, 2017 at 12:59 PM, Keerthy <j-keerthy@ti.com> wrote:
> On Thursday 20 July 2017 03:12 PM, Keerthy wrote:
>> Currently davinci_gpio_irq_setup return value is ignored. Handle the
>> return value appropriately.
>
> Linus,
>
> Any comments on this? Sorry if i pinged too soon. The rest 2 of this
> series were pulled by you. So just wanted to check on this one if you
> had specific comments.

I got the impression you would send this in a series with a new
patch requested by Johan.

Do we have consensus that this patch should be applied as-is?

Yours,
Linus Walleij
