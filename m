From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 25 Jan 2016 14:32:19 +0100
Subject: ARM: mvebu_v5_defconfig: Remove obsolete SND_KIRKWOOD_SOC_T5325
In-Reply-To: <20160116172629.GC9880@lunn.ch> (Andrew Lunn's message of "Sat,
 16 Jan 2016 18:26:29 +0100")
References: <20160111042512.GA30997@jirafa.cyrius.com>
 <20160116172629.GC9880@lunn.ch>
Message-ID: <877fixg4yk.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Martin
 
 On sam., janv. 16 2016, Andrew Lunn <andrew@lunn.ch> wrote:

> On Sun, Jan 10, 2016 at 08:25:12PM -0800, Martin Michlmayr wrote:
>> The kirkwood-t5325 driver driver was removed in commit 270a85c80c86
>> ("ASoC: kirkwood: Remove unused drivers") in favour of DT based
>> simple-card equivalents.  Remove the obsolete config option.
>> 
>> Signed-off-by: Martin Michlmayr <tbm@cyrius.com>
>
> Reviewd-by: Andrew Lunn <andrew@lunn.ch>

Actually this change was already done in 8c95b85c0ba2 ("ARM: mvebu:
update v5 defconfig"). So I won't apply it.

Thanks,

Gregory

>
> Thanks
> 	Andrew
>
>> ---
>>  arch/arm/configs/mvebu_v5_defconfig | 1 -
>>  1 file changed, 1 deletion(-)
>> 
>> diff --git a/arch/arm/configs/mvebu_v5_defconfig b/arch/arm/configs/mvebu_v5_defconfig
>> index 824de49..79e6260 100644
>> --- a/arch/arm/configs/mvebu_v5_defconfig
>> +++ b/arch/arm/configs/mvebu_v5_defconfig
>> @@ -108,7 +108,6 @@ CONFIG_SOUND=y
>>  CONFIG_SND=y
>>  CONFIG_SND_SOC=y
>>  CONFIG_SND_KIRKWOOD_SOC=y
>> -CONFIG_SND_KIRKWOOD_SOC_T5325=y
>>  CONFIG_SND_SOC_ALC5623=y
>>  CONFIG_SND_SIMPLE_CARD=y
>>  CONFIG_REGULATOR=y
>> -- 
>> 2.1.4
>> 
>> -- 
>> Martin Michlmayr
>> http://www.cyrius.com/
>> 
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
