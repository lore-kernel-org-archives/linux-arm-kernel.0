From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 27 May 2010 11:57:17 +0200
Subject: [PATCH] atmel_serial: Atmel RS485 support v2
In-Reply-To: <4BFE2F38.8050200@evidence.eu.com>
References: <4BB053C4.7050700@evidence.eu.com>	<4BB10304.6090006@bluewatersys.com>	<4BB1BF49.2000609@evidence.eu.com>	<4BB252E3.3030703@bluewatersys.com>	<4BBD8C9D.3070401@evidence.eu.com>	<20100408111310.524f7354@lxorguk.ukuu.org.uk>	<4BBDD71D.1010700@evidence.eu.com>
	<4BFD1FB6.8050405@atmel.com> <4BFE2F38.8050200@evidence.eu.com>
Message-ID: <4BFE41FD.2080804@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 27/05/2010 10:37, Claudio Scordino :
> Nicolas Ferre ha scritto:
>> Le 08/04/2010 15:16, Claudio Scordino :
>>
>> [..]
>>
>>   
>>> atmel_serial: Atmel RS485 support
>>>
>>> Signed-off-by: Claudio Scordino <claudio@evidence.eu.com>
>>> Signed-off-by: Michael Trimarchi <michael@evidence.eu.com>
>>> Signed-off-by: Rick Bronson <rick@efn.org>
>>> Signed-off-by: Sebastian Heutling <Sebastian.Heutling@who-ing.de>
>>> Tested-by: Sebastian Heutling <Sebastian.Heutling@who-ing.de>
>>> Reviewed-by: Ryan Mallon <ryan@bluewatersys.com>
>>>     
>>
>> Even though I personally did not test this patch I think it is time to
>> go forward with this very good work.
>>
>> Considering the number of people involved in this testing and review I
>> think that we can submit this patch for mainline. Who will handle it?
>> - do we submit to ARM or serial subsystem ?
>>   
> 
> Hi Nicolas,
> 
>     the latest version of the patch has been already merged in the
> latest Linus' git tree through Russell King's patchsystem 

My fault: I use to check Russell patchsystem with "AT91" searching
string and not "atmel" ;-)

> (the maintainer of the driver never answered to emails...).

I was supposed to take over its maintainance one year ago but did not
find time to do it. My fault here also...

Anyway, it was the occasion to tell all of you that this RS485 support
is a nice job and that even if I do not answer, I try to track all
interesting activity in the background.

Best regards,
-- 
Nicolas Ferre
