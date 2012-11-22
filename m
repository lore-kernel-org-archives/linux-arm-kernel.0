From: narkewoody@gmail.com (Woody Wu)
Date: Thu, 22 Nov 2012 05:35:36 +0000 (UTC)
Subject: Where CONFIG_DRAM_BASE/CONFIG_DRAM_SIZE defined?
References: <slrnkaoc27.2jk.narkewoody@zuhnb712.local.com>
 <50AC5F40.5080805@snapgear.com>
Message-ID: <slrnkarebm.av9.narkewoody@zuhnb712.local.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2012-11-21, Greg Ungerer <gerg@snapgear.com> wrote:
> On 11/21/2012 11:38 AM, Woody Wu wrote:
>> I found arm code is referring two definitions CONFIG_DRAM_BASE and
>> CONFIG_DRAM_SIZE. But I searched through the code, still cannot find
>> where they are defined?
>>
>> Do you know where are they?
>
> arch/arm/Kconfig-nommu
>
> Regards
> Greg
>
>

Thanks! Next time I will search the code without the prefix "CONFIG_".


-- 
woody
I can't go back to yesterday - because I was a different person then.
