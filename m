From: dhaval.vasa@einfochips.com (Dhaval Vasa)
Date: Thu, 08 Oct 2009 17:40:10 +0530
Subject: kirkwood: missing pci support for openrd_base board
In-Reply-To: <200910081344.09483.dk-arm-linux@gmx.de>
References: <200910081333.43065.dk-arm-linux@gmx.de>
	<20091008133329.675796da@marrow.netinsight.se>
	<200910081344.09483.dk-arm-linux@gmx.de>
Message-ID: <4ACDD6A2.5080004@einfochips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Simon,

I will verify and ACK on mailing list.

- Dhaval

Dieter Kiermaier wrote:
> Simon,
> 
>> (I suggest we move this discussion to the OpenRD mailing list only in
>> the future)
>>
>> On Thu, 8 Oct 2009 13:33:42 +0200
>> Dieter Kiermaier <dk-arm-linux@gmx.de> wrote:
>>
>>> I try most recent kernel form kernel.org:
>>>
>>> Linux DB88FXX81 2.6.32-rc3-00052-g0eca52a #5 PREEMPT Thu Oct 8 13:20:27 CEST 2009 armv5tel GNU/Linux
>>>
>>> So everything else seems to work well but I can't get pci bus working?
>>> Is PCI expected to work or are there some patches missing (and if so, where are they available?)
>> It's just because PCIe initialization isn't called. I sent this patch
>> over a month ago, but it hasn't been merged yet:
>>
>>   http://www.spinics.net/lists/arm-kernel/msg73112.html
> 
> Many thanks for the patch - I've googled a lot but can't find the information.
> Sorry for the noise!
> 
> Dieter
> 
> 
>> // Simon
>>
-- 
_____________________________________________________________________
Disclaimer: This e-mail message and all attachments transmitted with it
are intended solely for the use of the addressee and may contain legally
privileged and confidential information. If the reader of this message
is not the intended recipient, or an employee or agent responsible for
delivering this message to the intended recipient, you are hereby
notified that any dissemination, distribution, copying, or other use of
this message or its attachments is strictly prohibited. If you have
received this message in error, please notify the sender immediately by
replying to this message and please delete it from your computer. Any
views expressed in this message are those of the individual sender
unless otherwise stated.Company has taken enough precautions to prevent
the spread of viruses. However the company accepts no liability for any
damage caused by any virus transmitted by this email.
_____________________________________________________________________
 
