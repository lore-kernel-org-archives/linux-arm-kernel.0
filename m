From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 27 Jul 2016 18:09:26 +0200
Subject: [PATCH 04/18] ARM: mvebu: a385-db-ap: enable USB (orion-ehci) port
In-Reply-To: <87oa5jm5ps.fsf@free-electrons.com> (Gregory CLEMENT's message of
 "Wed, 27 Jul 2016 18:00:15 +0200")
References: <1469105055-25181-1-git-send-email-jaz@semihalf.com>
 <1469105055-25181-5-git-send-email-jaz@semihalf.com>
 <87oa5jm5ps.fsf@free-electrons.com>
Message-ID: <87a8h3m5ah.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
 
 On mer., juil. 27 2016, Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:

> Hi Grzegorz,
>  
>  On jeu., juil. 21 2016, Grzegorz Jaszczyk <jaz@semihalf.com> wrote:
>
>> Signed-off-by: Grzegorz Jaszczyk <jaz@semihalf.com>
>
>
> Here agina, as pointed by Andrew a commit log entry would be
> nice. Except this:
>
> Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

I also forget to mention that the title prefix should be change to:
"ARM: dts: mvebu: a385-db-ap:"

Gregory
>
> Thanks,
>
> Gregory
>> ---
>>  arch/arm/boot/dts/armada-385-db-ap.dts | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/armada-385-db-ap.dts b/arch/arm/boot/dts/armada-385-db-ap.dts
>> index 2d3fd6e..a18f516 100644
>> --- a/arch/arm/boot/dts/armada-385-db-ap.dts
>> +++ b/arch/arm/boot/dts/armada-385-db-ap.dts
>> @@ -155,6 +155,10 @@
>>  				bm,pool-short = <3>;
>>  			};
>>  
>> +			usb at 58000 {
>> +				status = "okay";
>> +			};
>> +
>>  			/* CON4 */
>>  			ethernet at 70000 {
>>  				pinctrl-names = "default";
>> -- 
>> 1.8.3.1
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
