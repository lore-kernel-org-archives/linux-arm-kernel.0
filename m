From: neidhard.kim@lge.com (Jongsung Kim)
Date: Thu, 16 May 2013 22:26:41 +0900
Subject: [PATCH] ARM: PL011: add support for extended FIFO-size of
 PL011-r1p5
In-Reply-To: <5193164E.6050400@wwwdotorg.org>
References: <007301ce375e$bcf6d6b0$36e48410$@lge.com>
 <5191D200.3040604@wwwdotorg.org> <01fd01ce5072$d6b9fcd0$842df670$@lge.com>
 <5192A692.4010700@wwwdotorg.org> <022d01ce5107$8bc668e0$a3533aa0$@lge.com>
 <5193164E.6050400@wwwdotorg.org>
Message-ID: <02e901ce5239$013b2570$03b17050$@lge.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Warren <swarren@wwwdotorg.org> :
>> All r1p5 have 32-byte FIFO depth and it's not configurable. From the
PL011
>> TRM:
>> 
>> r1p4-r1p5	Contains the following differences in functionality:
>> 		* The receive and transmit FIFOs are increased to a depth of
32.
>> 		* The Revision field in the UARTPeriphID2 Register on page
3-24
>> 		  bits [7:4] now reads back as 0x3.
>
> Well, that certainly isn't true in practice. I think we should revert
> this commit until we can determine what the problem is.

I asked to the ARM support about this. Waiting for reply..
