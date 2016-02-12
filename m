From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 12 Feb 2016 21:55:53 +0100
Subject: [PATCH 1/4] dma: mmp_pdma: Add the #requestors DT property
 documentation
In-Reply-To: <2622040.i4begfCjyO@wuerfel> (Arnd Bergmann's message of "Thu, 11
 Feb 2016 22:59:51 +0100")
References: <1455225798-9510-1-git-send-email-robert.jarzmik@free.fr>
 <1455225798-9510-2-git-send-email-robert.jarzmik@free.fr>
 <2622040.i4begfCjyO@wuerfel>
Message-ID: <87vb5t1wdi.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> On Thursday 11 February 2016 22:23:15 Robert Jarzmik wrote:
>> @@ -12,6 +12,8 @@ Required properties:
>>  Optional properties:
>>  - #dma-channels: Number of DMA channels supported by the controller (defaults
>>    to 32 when not specified)
>> +- #requestors: Number of DMA requestor lines supported by the controller
>> +  (defaults to 0 when not specified)
>>  
>> 
>
> Most other ones use "#dma-requests" as the property name here, I think it makes
> sense to stay with that convention.

Most certainly, for v2.

I'll await for a couple of days for other reviews, especially Vinod's one and
Haojian's ack for the .h change.

Cheers.

-- 
Robert
