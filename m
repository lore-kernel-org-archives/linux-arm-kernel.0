From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Sat, 4 Jun 2011 12:23:13 +0400
Subject: [PATCH 2/2] mtd: drop ceiva map driver
In-Reply-To: <1307116159.3069.22.camel@localhost>
References: <1307015648-17505-1-git-send-email-dbaryshkov@gmail.com>
	<1307015648-17505-2-git-send-email-dbaryshkov@gmail.com>
	<1307116159.3069.22.camel@localhost>
Message-ID: <BANLkTim0e4OYbSvwq1nENWkcUFynjV3ksg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 6/3/11, Artem Bityutskiy <Artem.Bityutskiy@nokia.com> wrote:
> On Thu, 2011-06-02 at 15:54 +0400, Dmitry Eremin-Solenikov wrote:
>> The same functionality is provided by physmap flash driver,
>> drivers/mtd/maps/ceiva.c didn't receive any functional changes since
>> the start of current git history, so drop it.
>>
>> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
>
> How about this: I take this patch to l2-mtd-2.6, but not taking the
> first patch. If someone complains that he needs ceiva, we'll add you
> first patch. Otherwise, you should kill all the other ceiva bits. Is
> this OK?

Yes, this is perfectly fine with me. Anyway, I'm still waiting for a response
from Russell/linux-arm-kernel regarding ceiva & whole clps sub-arch.

-- 
With best wishes
Dmitry
