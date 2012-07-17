From: jason77.wang@gmail.com (Hui Wang)
Date: Tue, 17 Jul 2012 09:42:42 +0800
Subject: [PATCH 3/3] ARM: convert asm/irqflags.h to use
 asm-generic/irqflags.h
In-Reply-To: <50043D07.7050608@gmail.com>
References: <1342410836-6010-1-git-send-email-robherring2@gmail.com>
 <1342410836-6010-4-git-send-email-robherring2@gmail.com>
 <5003B648.30802@gmail.com> <50043D07.7050608@gmail.com>
Message-ID: <5004C312.1010003@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


>
> In most cases, I think inlines are preferred as they have type checking.
>   
Make sense.
> Doesn't really matter to me.
>   
Just a small case. :-)

Regards,
Hui.
> Rob
>
>   
>>> +#include <asm-generic/irqflags.h>
>>>  
>>>  #endif
>>>  #endif
>>>   
>>>       
>
>
>
>   
