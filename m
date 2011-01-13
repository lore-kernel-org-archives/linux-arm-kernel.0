From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Thu, 13 Jan 2011 11:12:59 +0900
Subject: [PATCH/RFC 1/3] ARM: S5P: Add a platform callback for MIPI CSIS
	PHY control
In-Reply-To: <020301cbb2c1$5ed9dec0$1c8d9c40$%kim@samsung.com>
References: <1294153764-25006-1-git-send-email-s.nawrocki@samsung.com>
	<1294153764-25006-2-git-send-email-s.nawrocki@samsung.com>
	<020301cbb2c1$5ed9dec0$1c8d9c40$%kim@samsung.com>
Message-ID: <4D2E5FAB.6010106@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

thank you for the update.

On 01/13/2011 10:29 AM, Kukjin Kim wrote:
> Sylwester Nawrocki wrote:
>>
>> The phy_enable callback in struct s5p_platform_mipi_csis is added
>> to allow the CSIS driver to control its PHY enable and reset signals.
>> This allows to use same MIPI CSIS driver across various SoCs.
>>
>> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>>  arch/arm/plat-s5p/dev-csis0.c              |    2 +-
>>  arch/arm/plat-s5p/dev-csis1.c              |    2 +-
>>  arch/arm/plat-s5p/include/plat/csis.h      |   28 --------------------
>>  arch/arm/plat-s5p/include/plat/mipi_csis.h |   39
>> ++++++++++++++++++++++++++++
>>  4 files changed, 41 insertions(+), 30 deletions(-)
>>  delete mode 100644 arch/arm/plat-s5p/include/plat/csis.h
>>  create mode 100644 arch/arm/plat-s5p/include/plat/mipi_csis.h
>>
...
> 
> I think should be separated like following.
> 
> If required, ...
> 
> 1. change copyright
> 2. rename csis.h to mipi_csis.h

I don't want to bother with a separate patches for that, just prefer
to drop the above changes.

> 3. add phy enable feature

OK, I would reduce the patch to that change only.

Regards,
-- 
Sylwester Nawrocki
Samsung Poland R&D Center
