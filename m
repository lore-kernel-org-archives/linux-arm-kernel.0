From: wxt@rock-chips.com (Caesar Wang)
Date: Tue, 16 Jun 2015 10:00:30 +0800
Subject: [PATCH v15 3/4] soc: rockchip: power-domain: add power domain
 driver
In-Reply-To: <1434380419.2069.38.camel@x220>
References: <1434258820-26779-1-git-send-email-wxt@rock-chips.com>	
 <1434258820-26779-4-git-send-email-wxt@rock-chips.com>
 <1434380419.2069.38.camel@x220>
Message-ID: <557F833E.9000905@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2015?06?15? 23:00, Paul Bolle ??:
> On Sun, 2015-06-14 at 13:13 +0800, Caesar Wang wrote:
>
>> --- /dev/null
>> +++ b/drivers/soc/rockchip/Kconfig
>> +config PM_GENERIC_DOMAINS
>> +        tristate "Rockchip generic power domain"
> Since my remarks on v13 you removed the module specific code from
> pm_domains.c. But now this became a tristate symbol. That makes little
> sense. Why didn't you keep bool?

Yeah, you are right. :s/tristate/bool

I forget it when the driver is moving from 'arch/arm/mach-rockchip/' to 
'/driver/soc/rockchip/'.
>
>> +        depends on PM
>> +        help
>> +          Say y here to enable power doamin support.
> s/doamin/domain/.

Done.
>> +          In order to meet high performance and low power requirements, a power
>> +          management unit is designed or saving power when RK3288 in low power
>> +          mode. The RK3288 PMU is dedicated for managing the power ot the whole chip.
> s/ot/of/

Done.
>> +          If unsure, say N.
> Thanks,
>
>
> Paul Bolle

Thanks,

Caesar

>
>
>

-- 
Thanks,
- Caesar
