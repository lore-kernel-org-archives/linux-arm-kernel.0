From: jiri.prchal@aksignal.cz (=?UTF-8?B?SmnFmcOtIFByY2hhbA==?=)
Date: Mon, 18 May 2015 08:25:16 +0200
Subject: at91sam9: watchdog: period
In-Reply-To: <5556006D.30306@atmel.com>
References: <55559D55.6020703@aksignal.cz>
 <BN3PR0501MB109030A3B29685D9188F6B71BBC70@BN3PR0501MB1090.namprd05.prod.outlook.com>
 <5556006D.30306@atmel.com>
Message-ID: <555985CC.1000707@aksignal.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 15.5.2015 16:19, Nicolas Ferre wrote:
>> I have the same hardware setup and the watchdog timeout is 15
>> seconds for me. For my kernel, I am using the Atmel fork at
>> github.com/linux4sam/linux-at91, master branch at commit
>> 5d5b332821753d616e65da6237f0a3330e59b98f.
>
> FYI, I've just moved the master branch of our github to the newer
> 3.18-based branch: linux-3.18-at91.
>
> Bye,

Since this files at91sam9_wdt.c and at91sam9_wdt.h are without changes between git 3.18 and 4.0.3 I think the problem is 
somewhere else. Later I can try whole git 3.18 kernel, now I don't have time for it.

Bye
