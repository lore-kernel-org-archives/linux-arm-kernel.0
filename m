From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 27 Mar 2015 10:48:42 +0100
Subject: at91 clocks
In-Reply-To: <551522C5.50202@microbit.se>
References: <55117568.6090202@microbit.se>
 <20150325013201.3f01fc22@bbrezillon> <55127AA6.5050902@microbit.se>
 <20150325173751.0d6479df@bbrezillon> <5512FBEB.2060609@atmel.com>
 <551522C5.50202@microbit.se>
Message-ID: <5515277A.7050107@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 27/03/2015 10:28, Jonas Andersson a ?crit :
> Hi Nicolas,
> 
> On 2015-03-25 19:18, Nicolas Ferre wrote:
>> I tried kernel 4.0-rc5 but it hangs in boot after ethernet init.
>>> Is this related to the changes I suggested ?
>> It seems to be related as I tried to boot an at91sam9260ek with current
>> Linus' tree and it doesn't hangs after Ethernet on my side...
>>
> Could you send me your dts and .config? I can not boot any unmodified 
> 4.0 rc on my board. Tested rc1, rc4, rc5, HEAD.

Yes: here are they:
at91sam9260ek.dts
http://paste.debian.net/163475/

.config
http://paste.debian.net/163477/

Best regards,

> Output
> ...
> [    1.730000] macb fffc4000.ethernet eth0: attached PHY driver [Generic 
> PHY] (mii_bus:phy_addr=fffc4000.etherne:00, irq=-1)
> [   82.570000] random: nonblocking pool is initialized
> 
> Best regards
>   Jonas
> 
> 
> 


-- 
Nicolas Ferre
