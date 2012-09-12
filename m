From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 12 Sep 2012 15:04:47 +0200
Subject: [PATCH 18/19] gpio: Provide the tc3589x GPIO expander driver with
 an IRQ domain
In-Reply-To: <CACRpkdYbWEq5mhTcewmxEpcivXkVyQS_56QRU67G40zcRXnUCA@mail.gmail.com>
References: <1347016499-29354-1-git-send-email-lee.jones@linaro.org>
 <1347016499-29354-19-git-send-email-lee.jones@linaro.org>
 <CACRpkdYbWEq5mhTcewmxEpcivXkVyQS_56QRU67G40zcRXnUCA@mail.gmail.com>
Message-ID: <CACRpkdaQHdxRZLMPZF6Ub4hcPhUc1ZK5goyGpBEWU2LqTGStaA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 10, 2012 at 3:10 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Fri, Sep 7, 2012 at 1:14 PM, Lee Jones <lee.jones@linaro.org> wrote:
>
>> In preparation for Device Tree enablement all IRQ controllers
>> should control their own IRQ domain. This patch provides just
>> that for the tc3589x GPIO expander.
>>
>> CC: Grant Likely <grant.likely@secretlab.ca>
>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
>
> Looks very good again,
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>
> I presume you will want to push the whole shebang through
> ARM SoC, but if that doesn't work out I am very tempted to
> apply this patch to the GPIO tree immediately so it lands
> in v3.7.

If I hear nothing I will probably apply this to the GPIO tree
tonight since it's a real nice patch and we really need irqdomain
conversion to happen all over the place... this driver has
many users so I want some rotation in linux-next for it.

Yours,
Linus Walleij
