From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Sat, 2 Apr 2011 18:46:18 +0400
Subject: [PATCH 6/7] pxa25x: drop handling of udc_is_connected
In-Reply-To: <4D962149.9090507@ru.mvista.com>
References: <1301666188-11822-1-git-send-email-dbaryshkov@gmail.com>
	<1301666188-11822-6-git-send-email-dbaryshkov@gmail.com>
	<4D962149.9090507@ru.mvista.com>
Message-ID: <AANLkTimwwCvXNZeMyf-P76Con15D6PKKQZE_npASYmAQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/1/11, Sergei Shtylyov <sshtylyov@mvista.com> wrote:
> Hello.
>
> Dmitry Eremin-Solenikov wrote:
>
>> There are no more users of udc_is_connected. Drop this field from
>> mach_info
>
>     If I don't mistake, this patch does more than just that.
>
>> and stop using it in pxa25x_udc.
>
>     Hm, I don't see where you're doing that. Instead you're changing some
> checks
> for gadget speed and adding some code. And you've said that the driver never
> used that thing before. Hm?

Strange. I thought I cleaned up this patch. There are some leftovers
from previous
rebases. Correct patch as it is now includes only the part regarding
udc_is_connected
field.

I'll wait for more review comments and then resend the whole serie.

-- 
With best wishes
Dmitry
