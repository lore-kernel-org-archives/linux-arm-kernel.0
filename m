From: mirqus@gmail.com (=?ISO-8859-2?Q?Micha=B3_Miros=B3aw?=)
Date: Thu, 29 Sep 2011 20:44:15 +0200
Subject: [PATCH 1/5] ARM: pxa: remove redundant macro on GPIO
In-Reply-To: <1317309546-19682-1-git-send-email-haojian.zhuang@marvell.com>
References: <2011092901>
	<1317309546-19682-1-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <CAHXqBFJnS7-x-Q8aJhNhbbVHhFHWS4PTVb0369p2H42Tm4J=HQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/9/29 Haojian Zhuang <haojian.zhuang@marvell.com>:
[...]
> ? ? ? ?if (type & IRQ_TYPE_EDGE_RISING)
> - ? ? ? ? ? ? ? GRER0 |= GPIO_bit(gpio);
> + ? ? ? ? ? ? ? GRER(gpio) |= GPIO_bit(gpio);
[...]

This looks wrong. There are more occurrences like this. Can you
explain if this is correct?

Best Regards,
Micha? Miros?aw
