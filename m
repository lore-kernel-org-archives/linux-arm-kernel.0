From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 7 May 2014 10:03:18 +0200
Subject: [PATCH] rtc: rtc-at91rm9200: fix infinite wait for ACKUPD irq
In-Reply-To: <20140506211040.GF11243@piout.net>
References: <94c06375c1b44c8eb5233b0ccf2e4b13@BY2PR05MB048.namprd05.prod.outlook.com>
 <1399386481-18643-1-git-send-email-boris.brezillon@free-electrons.com>
 <aed75d16aa46476eb6f6c5b0d4bef30d@BLUPR05MB037.namprd05.prod.outlook.com>
 <20140506211040.GF11243@piout.net>
Message-ID: <5369E8C6.1070409@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/05/2014 23:10, Alexandre Belloni :
> Hi,
> 
> On 06/05/2014 at 19:06:56 +0000, Bryan Evenson wrote :
>>
>> I'd assume this patch would be backported to the longterm releases?
>>
> 
> If by longterm, you mean the linux4sam tree, 3.10 branch, it is up to
> Nicolas to take it. I believe it will be pretty easy to convince him ;)

Absolutely, it is always easy to convince me with:
- good commit message
- script to reproduce the issue
- follow-up of the patch plus testing
- dialogue between skilled kernel developers

So, yes, I will "ack" the patch and immediately integrate it in our
linux4sam 3.10 branch.

On the other hand, I let Boris add the "stable" tag to his original patch.

Thanks to all of you for this fix. Bye,
-- 
Nicolas Ferre
