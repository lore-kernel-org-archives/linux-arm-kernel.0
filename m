From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 14 Dec 2017 12:30:08 +0100
Subject: [PATCH v3 07/11] thermal: armada: Update Kconfig and module
 description
In-Reply-To: <20171214121706.529f9652@xps13> (Miquel RAYNAL's message of "Thu,
 14 Dec 2017 12:17:06 +0100")
References: <20171214103011.24713-1-miquel.raynal@free-electrons.com>
 <20171214103011.24713-8-miquel.raynal@free-electrons.com>
 <87po7ho93k.fsf@free-electrons.com> <20171214121706.529f9652@xps13>
Message-ID: <87efnxo8cf.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Miquel,
 
 On jeu., d?c. 14 2017, Miquel RAYNAL <miquel.raynal@free-electrons.com> wrote:

> Hi Gregory,
>
> On Thu, 14 Dec 2017 12:13:51 +0100
> Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:
>
>> Hi Miquel,
>>  
>>  On jeu., d?c. 14 2017, Miquel Raynal
>> <miquel.raynal@free-electrons.com> wrote:
>> 
>> > Update Armada thermal driver Kconfig entry as well as the driver's
>> > MODULE_DESCRIPTION content, now that 64-bit SoCs are also supported,
>> > eg. Armada 7K and Armada 8K.
>> >
>> > Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
>> > ---
>> >  drivers/thermal/Kconfig          | 4 ++--
>> >  drivers/thermal/armada_thermal.c | 2 +-
>> >  2 files changed, 3 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
>> > index 315ae2926e20..44cad046f272 100644
>> > --- a/drivers/thermal/Kconfig
>> > +++ b/drivers/thermal/Kconfig
>> > @@ -301,13 +301,13 @@ config DB8500_THERMAL
>> >  	  thermal zone if trip points reached.
>> >  
>> >  config ARMADA_THERMAL
>> > -	tristate "Armada 370/XP thermal management"
>> > +	tristate "Armada 370/XP/7K/8K thermal management"  
>> if you want to be exhaustive you should also add Armada 375 and 38x.
>
> That is right, both are missing from the description, but wouldn't it
> be better to just state "Armada SoCs" instead of patching that file
> everythime a new SoC reuses this IP?

Unfortunately Armada SoCs is more that just these SoC!

Have a look on Documentation/arm/Marvell/README to see how the Marvell
marketing guys had been creative :)

Some kirkwood are called Armada 300 and Armada 310.
The Dove is also called Armada 510.
Some PXA are called Armada too such as Armada 168 or Armada 610.
And finally the Berlin also use Aramda as code name: Armada 1000 or
Aramda 1500

Gregory

>
> Thanks,
> Miqu?l
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
