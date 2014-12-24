From: elder@linaro.org (Alex Elder)
Date: Wed, 24 Dec 2014 08:02:30 -0600
Subject: [PATCH] linux/kernel.h: merge ARRAY_AND_SIZE defines
In-Reply-To: <1419399879.6157.9.camel@perches.com>
References: <1419399496-5955-1-git-send-email-yamada.m@jp.panasonic.com>
 <1419399879.6157.9.camel@perches.com>
Message-ID: <549AC776.8090905@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/23/2014 11:44 PM, Joe Perches wrote:
> On Wed, 2014-12-24 at 14:38 +0900, Masahiro Yamada wrote:
>> ARRAY_AND_SIZE is a useful macro.  Its definition is already
>> duplicated in some headers.  Move it to include/linux/kernel.h.
> 
> I think it's not a good/useful macro and
> would prefer the uses expanded instead.

For what it's worth, I agree.	-Alex

> The uses of ARRAY_AND_SIZE in structure
> definitions aren't particularly bad, but the
> ARRAY_AND_SIZE uses that hide the number of
> arguments in a function I think are suboptimal.
> 
> 
