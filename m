From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 19 Nov 2014 18:35:56 +0100
Subject: [PATCH RESEND 0/4] hrng: atmel: add DT support
In-Reply-To: <20141119171824.1e8dc40d@bbrezillon>
References: <1416413278-10197-1-git-send-email-boris.brezillon@free-electrons.com>	<546CC233.6090605@atmel.com>
 <20141119171824.1e8dc40d@bbrezillon>
Message-ID: <546CD4FC.9030701@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/11/2014 17:18, Boris Brezillon :
> On Wed, 19 Nov 2014 17:15:47 +0100
> Nicolas Ferre <nicolas.ferre@atmel.com> wrote:
> 
>> On 19/11/2014 17:07, Boris Brezillon :
>>> Hello,
>>>
>>> This series adds DT support for the TRNG (True Random Generator) block and
>>> adds missing trng nodes to dtsi files.
>>
>> Nitpicking: subject of this cover letter seems not good ;-)
> 
> Sorry, you should read:
> 
> "hrng: atmel: add DT support"

Yep

>> Herbert, do you think you can take this series yourself or do I have to
>> take it?

Oh, and BTW some "Acked-by" tags from Peter are missing, did forget them
or changed something?

>> Bye,
>>
>>> Boris Brezillon (4):
>>>   hwrng: atmel: use clk_prepapre_enable/_disable_unprepare
>>>   hwrng: atmel: add DT support
>>>   hwrng: atmel: Add TRNG DT binding doc
>>>   ARM: at91/dt: add trng node
>>>
>>>  Documentation/devicetree/bindings/hwrng/atmel-trng.txt | 16 ++++++++++++++++
>>>  arch/arm/boot/dts/at91sam9g45.dtsi                     |  7 +++++++
>>>  drivers/char/hw_random/Kconfig                         |  2 +-
>>>  drivers/char/hw_random/atmel-rng.c                     | 15 +++++++++++----
>>>  4 files changed, 35 insertions(+), 5 deletions(-)
>>>  create mode 100644 Documentation/devicetree/bindings/hwrng/atmel-trng.txt
>>>
>>
>>
> 
> 
> 


-- 
Nicolas Ferre
