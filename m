From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 18 Jun 2013 00:58:41 +0900
Subject: [PATCH 2/3] pinctrl: s3c24xx: use correct header for chained_irq
 functions
In-Reply-To: <CACRpkdbmh5sXXycHHy0GYZY0WH5np0je1NU6jyHmb2h_VuagRA@mail.gmail.com>
References: <201306140044.15568.heiko@sntech.de>	<201306140045.51206.heiko@sntech.de>	<1a1801ce6b5c$d5395270$7fabf750$%kim@samsung.com>
 <CACRpkdbmh5sXXycHHy0GYZY0WH5np0je1NU6jyHmb2h_VuagRA@mail.gmail.com>
Message-ID: <51BF3231.1070505@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/18/13 00:45, Linus Walleij wrote:
> On Mon, Jun 17, 2013 at 3:16 PM, Kukjin Kim<kgene.kim@samsung.com>  wrote:
>> Heiko St?bner wrote:
>>>
>>> chained_irq_enter and chained_irq_exit moved to a real header under
>>> linux/pinctrl instead of asm/.
>>>
>>> Update the pinctrl driver to use the correct header and fix the build
>>> error.
>>>
>>> Signed-off-by: Heiko Stuebner<heiko@sntech.de>
> (...)
>>
>> Hmm, would be nice if I could take 1st and 2nd into samsung tree :-)
>>
>> Linus, if any problems, please let me know.
>
> No that should work fine. Nothing is touching pinctrl-s3c in my
> pinctrl tree so:
> Acked-by: Linus Walleij<linus.walleij@linaro.org>
>
Thanks, applied with Linus' ack.

- Kukjin
