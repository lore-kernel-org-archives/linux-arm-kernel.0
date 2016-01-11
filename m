From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 11 Jan 2016 17:24:28 +0100
Subject: [PATCH 1/2] ARM: mvebu: adjust board name and compatible for
 Armada 388 GP
In-Reply-To: <87r3ifrbgg.fsf@free-electrons.com> (Gregory CLEMENT's message of
 "Mon, 21 Dec 2015 17:52:15 +0100")
References: <1450708916-15966-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1450708916-15966-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <87r3ifrbgg.fsf@free-electrons.com>
Message-ID: <87h9ikythf.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
 
 On lun., d?c. 21 2015, Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:

> Hi Thomas,
>  
>  On lun., d?c. 21 2015, Thomas Petazzoni <thomas.petazzoni@free-electrons.com> wrote:
>
>> As the name of the Device Tree file name suggests, the Armada 388 GP
>> really contains an Armada 388 SoC, so this commit updates the board
>> name and compatible string in the Device Tree file.
>>
>> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>
> Applied on mvebu/dt

I didn't managed to do a pull request before the holidays period so I
moved this commit to mvebu/dt-for-4.6

Gregory

>
> Thanks,
>
> Gregory
>> ---
>>  arch/arm/boot/dts/armada-388-gp.dts | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/armada-388-gp.dts b/arch/arm/boot/dts/armada-388-gp.dts
>> index a633be3..d8dab0f 100644
>> --- a/arch/arm/boot/dts/armada-388-gp.dts
>> +++ b/arch/arm/boot/dts/armada-388-gp.dts
>> @@ -44,8 +44,8 @@
>>  #include <dt-bindings/gpio/gpio.h>
>>  
>>  / {
>> -	model = "Marvell Armada 385 GP";
>> -	compatible = "marvell,a385-gp", "marvell,armada388", "marvell,armada380";
>> +	model = "Marvell Armada 388 DB-88F6820-GP";
>> +	compatible = "marvell,a388-gp", "marvell,armada388", "marvell,armada380";
>>  
>>  	chosen {
>>  		stdout-path = "serial0:115200n8";
>> -- 
>> 2.6.4
>>
>
> -- 
> Gregory Clement, Free Electrons
> Kernel, drivers, real-time and embedded Linux
> development, consulting, training and support.
> http://free-electrons.com
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
