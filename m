From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Thu, 03 Mar 2011 10:34:21 +0100
Subject: [PATCH 1/3] ARM: S5P: Rename MIPI-CSIS header and update Copyright
In-Reply-To: <01a501cbd95c$37069cf0$a513d6d0$%kim@samsung.com>
References: <1299087289-29926-1-git-send-email-s.nawrocki@samsung.com>
	<1299087289-29926-2-git-send-email-s.nawrocki@samsung.com>
	<01a501cbd95c$37069cf0$a513d6d0$%kim@samsung.com>
Message-ID: <4D6F609D.3020501@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 03/03/2011 05:33 AM, Kukjin Kim wrote:
> Sylwester Nawrocki wrote:
>>
>> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>>  arch/arm/plat-s5p/dev-csis0.c              |    2 +-
>>  arch/arm/plat-s5p/dev-csis1.c              |    2 +-
>>  arch/arm/plat-s5p/include/plat/csis.h      |   28
> --------------------------
>> --
>>  arch/arm/plat-s5p/include/plat/mipi_csis.h |   28
>> ++++++++++++++++++++++++++++
>>  4 files changed, 30 insertions(+), 30 deletions(-)
>>  delete mode 100644 arch/arm/plat-s5p/include/plat/csis.h
>>  create mode 100644 arch/arm/plat-s5p/include/plat/mipi_csis.h
>>
> Oops, why didn't use '-M'?
> It can show me this like following.
> 

Yes, I could do better. Sorry, I had two version of the patch
and somehow ended up with te wrong one being send.

> .../plat-s5p/include/plat/{csis.h => mipi_csis.h}  |   10 +++++-----
>  3 files changed, 7 insertions(+), 7 deletions(-)
>  rename arch/arm/plat-s5p/include/plat/{csis.h => mipi_csis.h} (68%)
> 
> Secondly, I remember this...
> Following is your response at that time.
> http://lists.infradead.org/pipermail/linux-arm-kernel/2011-January/038037.ht
> ml
> 

Yes, but afterwards I realized there will be issues when one is trying
to build common kernel binary for multiple SoCs.
Nevertheless I will prepare common code for S5P and a callback into platform
code, so at least we can move on with the v4l driver.

Thanks,
-- 
Sylwester Nawrocki
Samsung Poland R&D Center
