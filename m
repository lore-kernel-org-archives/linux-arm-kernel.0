From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 2 Jul 2015 09:53:39 +0200
Subject: [RESEND PATCH 2/2] ARM: at91/dt: update udc compatible strings
In-Reply-To: <7h8uazmxa9.fsf@deeprootsystems.com>
References: <99dc2e0ec98342632b6e3adad3861f4dd0fcde41.1434530650.git.nicolas.ferre@atmel.com>	<8ec182ab7c5186a64d605d0e174e750994586f02.1434530650.git.nicolas.ferre@atmel.com>
 <7h8uazmxa9.fsf@deeprootsystems.com>
Message-ID: <5594EE03.5030606@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 01/07/2015 22:35, Kevin Hilman a ?crit :
> Nicolas Ferre <nicolas.ferre@atmel.com> writes:
> 
>> From: Boris Brezillon <boris.brezillon@free-electrons.com>
>>
>> at91sam9g45, at91sam9x5 and sama5 SoCs should not use
>> "atmel,at91sam9rl-udc" for their USB device compatible property since
>> this compatible is attached to a specific hardware bug fix.
>>
>> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
>> Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
>> Tested-by: Bo Shen <voice.shen@atmel.com>
>> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>> Cc: <stable@vger.kernel.org>  #4.0+
>> ---
>> Hi,
>>
>> This patch was forgotten while dealing with the series "usb: atmel_usba_udc:
>> Rework errata handling". This patch and the previous one should be added to
>> mainline as fixes, the soonest. In fact, the errata handling is now broken
>> because of this desynchronization.
>>
>> We'll try to queue it during 4.2-rc phase for inclusion in arm-soc tree.
> 
> I've picked both of these up for the arm-soc/late branch which I'll try
> to get in before -rc1, if not it will make it for -rc2.

Brilliant! Thanks a lot Kevin.

Bye,
-- 
Nicolas Ferre
