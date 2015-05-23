From: kgene@kernel.org (Kukjin Kim)
Date: Sat, 23 May 2015 11:16:36 +0900
Subject: [GIT PULL] Samsung related to updating multi_v7_defconfig
In-Reply-To: <2227456.dXyEpqfCYe@wuerfel>
References: <555D4BF5.20008@kernel.org> <2227456.dXyEpqfCYe@wuerfel>
Message-ID: <555FE304.5090706@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/23/15 00:15, Arnd Bergmann wrote:
> On Thursday 21 May 2015 12:07:33 Kukjin Kim wrote:
>>
>> Here is multi_v7_defconfig update and mostly including regarding exynos
>> stuff based on savedefconfig which could remove useless configs based on
>> checking of dependencies.
>>
>> This series is based on v4.1-rc1 and I can provide resolution of
>> conflicts with arm-soc/next/defconfig. See below.
>>
>> Note that, IMHO we need to check 'savedefconfig when defconfig is
>> updated so that we could remove useless lines and avoid to miss some
>> defconfigs because of dependency.
>>
>> Anyway please pull and if any concerns, please kindly let me know.
>>
Hi,

> The conflict got a little too wild for my taste, so I dropped your
> 'savedefconfig' commit and rebased the other ones on top of the
> branch I already had.
> 
OK, no problem :-)

> Please check that the result is still ok for you.
> 
When I checked, I didn't find any missing stuff from my side. Looks
good, thanks.

- Kukjin
