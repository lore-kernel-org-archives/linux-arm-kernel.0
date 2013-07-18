From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 18 Jul 2013 19:38:26 +0530
Subject: [PATCH RFC v2 13/14] ARM: debug: move davinci debug to generic
 8250 code
In-Reply-To: <20130717170233.GQ24642@n2100.arm.linux.org.uk>
References: <20130716163243.GY21614@n2100.arm.linux.org.uk>
 <E1Uz8OD-00048N-Be@rmk-PC.arm.linux.org.uk> <51E6887F.3090808@ti.com>
 <20130717170233.GQ24642@n2100.arm.linux.org.uk>
Message-ID: <51E7F6DA.7000505@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 17 July 2013 10:32 PM, Russell King - ARM Linux wrote:
> On Wed, Jul 17, 2013 at 05:35:19PM +0530, Sekhar Nori wrote:
>> On 7/16/2013 10:16 PM, Russell King wrote:
>>> Davinci's debugging is just a copy of the old 8250_32 code with a
>>> different base address.  Incorporate this into the generic 8250
>>> debug code.
>>>
>>> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>>
>> Tested on DA850 EVM
>>
>> Acked-by: Sekhar Nori <nsekhar@ti.com>
> 
> You may wish to consider whether a Tested-by tag would be a more accurate
> attributation if you actually tested the patch.

Okay, I chose Acked-by: because I also reviewed the patch to make sure
there are not typos in the addresses etc for the devices I did not test.

Thanks,
Sekhar
