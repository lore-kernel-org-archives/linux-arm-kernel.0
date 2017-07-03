From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 4 Jul 2017 00:16:24 +0900
Subject: [PATCH] irqchip: constify irq_domain_ops
In-Reply-To: <b5e49daf-efe5-b5b3-6abe-8c9ad4afc0ff@arm.com>
References: <1499091004-20909-1-git-send-email-yamada.masahiro@socionext.com>
 <b5e49daf-efe5-b5b3-6abe-8c9ad4afc0ff@arm.com>
Message-ID: <CAK7LNAQSf8QfCiKUGkaxr2G3x1dKAFfYwEJ81gutiwG6ijQzsg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

2017-07-03 23:15 GMT+09:00 Marc Zyngier <marc.zyngier@arm.com>:
> On 03/07/17 15:10, Masahiro Yamada wrote:
>> The core framework does not modify irq_domain_ops, so those driver
>> data can be qualified with 'const'.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
> Please check the current next, which has quite a few (if not all) of
> these already.
>

Ah, please ignore this, then.  Thanks.



-- 
Best Regards
Masahiro Yamada
