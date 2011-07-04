From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 04 Jul 2011 17:17:49 +0200
Subject: [PATCH for 3.0] AT91: Change nand buswidth logic to match hardware
	default configuration
In-Reply-To: <201107041713.23982.arnd@arndb.de>
References: <1309515924-22531-1-git-send-email-nicolas.ferre@atmel.com>
	<201107041625.25972.arnd@arndb.de> <4E11D123.9070409@atmel.com>
	<201107041713.23982.arnd@arndb.de>
Message-ID: <4E11D99D.7040005@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 04/07/2011 17:13, Arnd Bergmann :
> On Monday 04 July 2011, Nicolas Ferre wrote:
>>> In this case, studying the patch more closely shows that it's
>>> very harmless, but I'd rather not have to look that closely.
>>
>> Well, in fact it is a fix against what was introduced in a 3.0 patch
>> which I found to be wrong.
>> The reason because I do not want to be in next kernel is the fact that
>> it can puzzle the user (people that want to use kernel without changing
>> the system_rev between 2.6.39 -> 3.0 and again revert their changes for
>> 3.0 -> 3.1).
>>
>>> Am I correct that the bug is a regression against 2.6.39?
>>
>> No, in fact it was introduced during 3.0 early -rc.
> 
> That's what I mean by 'regression against 2.6.39': it was working in 2.6.39,
> but later kernels are broken without this fix.

Absolutely (here broken = not easily understandable by user).

Bye,
-- 
Nicolas Ferre
