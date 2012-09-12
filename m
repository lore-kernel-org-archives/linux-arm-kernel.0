From: robherring2@gmail.com (Rob Herring)
Date: Wed, 12 Sep 2012 15:50:58 -0500
Subject: [PATCH v2 5/6] ARM: orion: move custom gpio functions to
 orion-gpio.h
In-Reply-To: <201209122022.57399.arnd@arndb.de>
References: <1346960563-18689-1-git-send-email-robherring2@gmail.com>
 <201209122011.28080.arnd@arndb.de> <5050ED0A.2020100@gmail.com>
 <201209122022.57399.arnd@arndb.de>
Message-ID: <5050F5B2.4080906@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/12/2012 03:22 PM, Arnd Bergmann wrote:
> On Wednesday 12 September 2012, Rob Herring wrote:
>>> arch/arm/plat-orion/mpp.c:17:23: fatal error: plat/gpio.h: No such file or directory
>>>
>>> A similar problem happens in plat-orion/irq.c, which has grown a new
>>> #include of plat/gpio.h in a different branch that is now in arm-soc.
>>
>> It should be orion-gpio.h instead. I have this fixed in my tree.
>>
> 
> I just pulled your multi-plat branch and it still has the broken version.

I hadn't pushed it out, but now it is. It should be close to what I'll
send. Primarily I just need to add some acks.

Rob
