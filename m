From: gautamvivek1987@gmail.com (Vivek Gautam)
Date: Fri, 1 Apr 2016 05:52:30 -0700
Subject: [PATCH 1/2] phy: Group vendor specific phy drivers
In-Reply-To: <20160401113919.GC2987@vireshk-i7>
References: <1459510156-9147-1-git-send-email-gautam.vivek@samsung.com>
 <20160401113919.GC2987@vireshk-i7>
Message-ID: <CAFp+6iGwXJHAEgm3n1S4Dfp45egCPMdoMrOqsR6W9c865-7rwA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 1, 2016 at 4:39 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 01-04-16, 16:59, Vivek Gautam wrote:
>> Adding vendor specific directories in phy to group
>> phy drivers under their respective vendor umbrella.
>>
>> Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
>> ---
>>  drivers/phy/{ => st}/phy-spear1310-miphy.c        |   0
>>  drivers/phy/{ => st}/phy-spear1340-miphy.c        |   0
>>  rename drivers/phy/{ => st}/phy-spear1310-miphy.c (100%)
>>  rename drivers/phy/{ => st}/phy-spear1340-miphy.c (100%)
>>
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Thanks Viresh.

>
> --
> viresh
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Vivek Gautam
Samsung R&D Institute, Bangalore
India
