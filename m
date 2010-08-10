From: alex@digriz.org.uk (Alexander Clouter)
Date: Tue, 10 Aug 2010 12:53:52 +0100
Subject: [PATCH v2] OpenRD: Enable SD/UART selection for serial port 1
In-Reply-To: <4C612EEC.3090409@einfochips.com>
References: <1281428973-28957-1-git-send-email-tanmay.upadhyay@einfochips.com>
	<20100810085643.GE21175@chipmunk> <20100810085821.GF21175@chipmunk>
	<4C612856.6090405@einfochips.com> <20100810102817.GJ21175@chipmunk>
	<4C612EEC.3090409@einfochips.com>
Message-ID: <20100810115351.GL21175@chipmunk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

* Tanmay Upadhyay <tanmay.upadhyay@einfochips.com> [2010-08-10 16:20:20+0530]:
>
> On 08/10/2010 03:58 PM, Alexander Clouter wrote:
>>
>> * Tanmay Upadhyay<tanmay.upadhyay@einfochips.com>  [2010-08-10 15:52:14+0530]:
>>    
>>> Intention here is to provide SD support by default. It will be switched
>>> to UART mode only if someone asks to do so via kernel parameter. If
>>> someone doesn't give OR gives improper kernel parameter, he/she won't get
>>> UART1. It will simply fall-back to the default setting - which is SD
>>> support.
>>
>> My mis-type, I forgot to put a
>> 'kirkwood_sdio_init(&openrd_mvsdio_data);' after my added printk().
>>
> If I understood correctly, intention behind this is to inform user that  
> he/she made a mistake while passing the kernel parameters. Is this 
> correct?
>
Exactly, and there is no harm turning on the SD slot rather than UART1 
at the same time.

Cheers

-- 
Alexander Clouter
.sigmonster says: tax office, n.:
                  	Den of inequity.
