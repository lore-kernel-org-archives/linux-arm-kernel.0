From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Fri, 31 Oct 2014 13:33:37 +0400
Subject: [PATCH 09/15] ARM: sa1100: don't preallocate IRQ space for locomo
In-Reply-To: <CACRpkdZnAtXtdtKbuqj8a_6a=2jS_Jf6yrq=iz-GJV+4RifRhw@mail.gmail.com>
References: <1414454528-24240-1-git-send-email-dbaryshkov@gmail.com>
 <1414454528-24240-10-git-send-email-dbaryshkov@gmail.com>
 <CACRpkdZnAtXtdtKbuqj8a_6a=2jS_Jf6yrq=iz-GJV+4RifRhw@mail.gmail.com>
Message-ID: <CALT56yNE4FDLoriixXqbLTtOZdSZe5DHKxWO2yjj5-1mmLzGfw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-10-31 10:50 GMT+03:00 Linus Walleij <linus.walleij@linaro.org>:
> On Tue, Oct 28, 2014 at 1:02 AM, Dmitry Eremin-Solenikov
> <dbaryshkov@gmail.com> wrote:
>
>> As new locomo driver properly supports SPARSE_IRQ, stop playing with
>> NR_IRQS on sa1100 (locomo was the last chip requiring NR_IRQ tricks).
>>
>> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
>
> That's right! By moving to irqdomain things get even better :)

That is a separate topic in my repo. I'll push that after finishing with LoCoMo.


-- 
With best wishes
Dmitry
