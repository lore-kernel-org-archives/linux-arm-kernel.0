From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Sun, 5 Sep 2010 18:53:22 +0900
Subject: [PATCH] ARM: PL330: Accept revisions of the dmac
In-Reply-To: <AANLkTimC5Ru-cTGVynnCu2NntHrHa9pB1HSGWEEJNZT7@mail.gmail.com>
References: <1283502656-15445-1-git-send-email-jassisinghbrar@gmail.com>
	<AANLkTimC5Ru-cTGVynnCu2NntHrHa9pB1HSGWEEJNZT7@mail.gmail.com>
Message-ID: <AANLkTikeTyUtUQEobgi0eQX47jO0CQ2oGusojHv1ymED@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 5, 2010 at 6:14 PM, Linus Walleij
<linus.ml.walleij@gmail.com> wrote:
> 2010/9/3 Jassi Brar <jassisinghbrar@gmail.com>:
>
>> -#define PERIPH_ID_VAL ?((PART << 0) | (DESIGNER << 12) \
>> - ? ? ? ? ? ? ? ? ? ? ? ? | (REVISION << 20) | (INTEG_CFG << 24))
>> +#define PERIPH_ID_VAL ?((PART << 0) | (DESIGNER << 12))
>>
>> ?#define PCELL_ID_VAL ? 0xb105f00d
>
> Jassi, this kind of macros already exist in <linux/amba/bus.h>
> can't you just #include that and use these instead?
You mean to use amba_config/rev et al ?
But they work on struct amba_device *, and I have to form those
structs just to make use of the macros. How useful would that be?
Or I got you wrong?
Thanks.
