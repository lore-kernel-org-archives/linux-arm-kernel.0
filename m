From: rusty@rustcorp.com.au (Rusty Russell)
Date: Mon, 05 Jan 2015 10:08:22 +1030
Subject: [PATCH] linux/kernel.h: merge ARRAY_AND_SIZE defines
In-Reply-To: <549AC776.8090905@linaro.org>
References: <1419399496-5955-1-git-send-email-yamada.m@jp.panasonic.com>
 <1419399879.6157.9.camel@perches.com> <549AC776.8090905@linaro.org>
Message-ID: <87sifqp15d.fsf@rustcorp.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alex Elder <elder@linaro.org> writes:
> On 12/23/2014 11:44 PM, Joe Perches wrote:
>> On Wed, 2014-12-24 at 14:38 +0900, Masahiro Yamada wrote:
>>> ARRAY_AND_SIZE is a useful macro.  Its definition is already
>>> duplicated in some headers.  Move it to include/linux/kernel.h.
>> 
>> I think it's not a good/useful macro and
>> would prefer the uses expanded instead.
>
> For what it's worth, I agree.	-Alex

Me too.  It's fine in current usage, but I wouldn't want to see
more of it.

Cheers,
Rusty.
