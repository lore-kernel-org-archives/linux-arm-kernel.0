From: wxt@rock-chips.com (Caesar Wang)
Date: Sun, 20 Dec 2015 17:15:30 +0800
Subject: [PATCH v3 0/5] Fix a trivial typo and support rk3228/rk3399 SoCs
 for thermal driver.
In-Reply-To: <20151217200927.GC7999@localhost.localdomain>
References: <1449132523-18817-1-git-send-email-wxt@rock-chips.com>
 <20151217200927.GC7999@localhost.localdomain>
Message-ID: <567671B2.5060705@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


? 2015?12?18? 04:09, Eduardo Valentin ??:
> Hello,
>
> On Thu, Dec 03, 2015 at 04:48:38PM +0800, Caesar Wang wrote:
>> This series pacthes to support the next soc for this thermal driver.
>> I don't add the dts thermal data since these SoCs have *_not_* land
>> in this mainline. I believe these SoCs dts will land in this mainline
>> lately,
>> then I will add the thermal data for Heiko.
>>
>> This series patches can apply into Eduardo branch.
>> https://git.kernel.org/cgit/linux/kernel/git/evalenti/linux-soc-thermal.git
>>
>> Also, this series pacthes have built on github branch.
>> https://github.com/rockchip-linux/kernel/commits/develop4.4
>>
>> PATCH[1/5]:
>> That's bit ugly typo, sorry for sending again :(.
>>
>> PATCH[2/5]:
>> To fix a build warning came from Dan Carpenter report smatch check,
>> Thanks. :)
>>
>> PATCH[3/5]:
>> Add the rk3228/rk3399 SoCs compatible for dt-bindings.
>>
>> PATCH[4/5]:
>> Add the rk3228 SoCs for thermal driver.
>>
>> PATCH[5/5]:
>> Add the rk3399 SoCs for thermal driver based on PATCH[4/5].
> I applied all but 2/5.

Thanks Eduardo,

I send the new patch[2/5].
https://patchwork.kernel.org/patch/7891381/

>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip


-- 
caesar wang | software engineer | wxt at rock-chip.com
