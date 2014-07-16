From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 16 Jul 2014 15:00:51 +0200
Subject: [PATCH 18/19] ARM: SAMSUNG: Remove remaining legacy code
In-Reply-To: <1405506268.4408.28.camel@x220>
References: <1404496099-26708-1-git-send-email-t.figa@samsung.com>
 <1404496099-26708-19-git-send-email-t.figa@samsung.com>
 <1405506268.4408.28.camel@x220>
Message-ID: <53C67783.4090407@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16.07.2014 12:24, Paul Bolle wrote:
> On Fri, 2014-07-04 at 19:48 +0200, Tomasz Figa wrote:

[snip]

>> -config S5P_GPIO_DRVSTR
>> -	bool
>> -	help
>> -	  Internal configuration to get and set correct GPIO driver strength
>> -	  helper
>> -
> 
> This one is used (as a macro) in drivers/gpio/gpio-samsung.c. Is a patch
> that touches that macro queued somewhere?

The code you mention should be removed as well as it's no longer needed.
Will include in a follow-up series. Thanks for reporting this and
remaining missed parts.

Best regards,
Tomasz
