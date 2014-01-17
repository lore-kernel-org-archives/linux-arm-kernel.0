From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 17 Jan 2014 10:38:09 +0100
Subject: How to support SDIO wifi/bt in DT
In-Reply-To: <20140117090214.GA2348@piout.net>
References: <20140116133649.GV15937@n2100.arm.linux.org.uk>
 <3215037.8HVCjAeS8g@wuerfel>
 <CAOesGMgzi5Buduo2pd0PP8CvKVir69yZ-jjX0Gbda871GiD8rg@mail.gmail.com>
 <20140117090214.GA2348@piout.net>
Message-ID: <52D8FA01.9020609@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/01/2014 10:02, Alexandre Belloni :
> On Thu, Jan 16, 2014 at 09:15:17AM -0800, Olof Johansson wrote :
>> "for SDIO slots" is somewhat misleading; nearly all controllers only
>> do one slot/device per controller. The designware controller can do
>> multiple slots, and that adds a bit of driver and binding complexity
>> for something that seemingly not a single vendor has actually
>> implemented.
>>
>> So we can likely assume to keep these reset/power/clock lines per host
>> controller, no need to add a slot construct.
>>
> 
> Actually, the atmel chips have two slots per controller so it would
> probably be better to think about that now.

Moreover, we have DT description for this.
Cf. Documentation/devicetree/bindings/mmc/atmel-hsmci.txt

Best regards,
-- 
Nicolas Ferre
