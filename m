From: ludovic.desroches@atmel.com (ludovic.desroches)
Date: Thu, 9 Aug 2012 08:32:04 +0200
Subject: [PATCH RESEND v5 0/4] atmel-mci device tree support
In-Reply-To: <87hasexegg.fsf@octavius.laptop.org>
References: <1343136606-8874-1-git-send-email-ludovic.desroches@atmel.com>
 <87hasexegg.fsf@octavius.laptop.org>
Message-ID: <50235964.2080409@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 08/08/2012 05:14 AM, Chris Ball a ?crit :
> Hi,
>
> On Tue, Jul 24 2012, ludovic.desroches at atmel.com wrote:
>> From: Ludovic Desroches <ludovic.desroches@atmel.com>
>>
>> Hello,
>>
>> I resend this set of patches because patches 2, 3 and 4 were acked by
>> Jean-Christophe. Patch 1 was also acked by Jean-Christophe excepted for
>> cd-inverted property since it was redundant with gpio bindings.
>
> In future, it's helpful for me if you can add the Acked-by lines you
> receive into the patches when you resend them.  Thanks!
>

Ok.

>> I thought we were agree to go ahead since it was a common binding already
>> documented and it will concern all drivers.
>
> Agreed.  It's a documented core MMC binding, it's fine to use it.
>
>> Chris are you agree to take patch 1/4? Others patches may go to at91 tree,
>> isn't it?
>
> Yes, let's do that.  I've applied patch 1/4 to mmc-next for 3.7, and you
> can send the others via the at91 tree with the ACK that Arnd gave.

Thanks Chris.

Ludovic

>
> Thanks,
>
> - Chris.
>
