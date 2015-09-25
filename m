From: davem@davemloft.net (David Miller)
Date: Thu, 24 Sep 2015 23:05:22 -0700 (PDT)
Subject: [PATCH v3 0/9] Phy, mdiobus, and netdev struct device fixes
In-Reply-To: <5604A5EC.7060401@gmail.com>
References: <20150924191754.GC21513@n2100.arm.linux.org.uk>
 <5604A5EC.7060401@gmail.com>
Message-ID: <20150924.230522.2080343670036893514.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Thu, 24 Sep 2015 18:39:56 -0700

> On 24/09/15 12:17, Russell King - ARM Linux wrote:
>> Hi,
>> 
>> The third version of this series fixes the build error which David
>> identified, and drops the broken changes for the Cavium Thunger BGX
>> ethernet driver as this driver requires some complex changes to
>> resolve the leakage - and this is best done by people who can test
>> the driver.
>> 
>> Compared to v2, the only patch which has changed is patch 6
>>   "net: fix phy refcounting in a bunch of drivers"
>> 
>> I _think_ I've been able to build-test all the drivers touched by
>> that patch to some degree now, though several of them needed the
>> Kconfig hacked to allow it (not all had || COMPILE_TEST clause on
>> their dependencies.)
> 
> Tested-by: Florian Fainelli <f.fainelli@gmail.com>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> 
> Thanks for fixing that.

Series applied, thanks.
