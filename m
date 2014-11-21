From: kgene@kernel.org (Kukjin Kim)
Date: Sat, 22 Nov 2014 00:19:16 +0900
Subject: [GIT PULL] Samsung clock changes for 3.19
In-Reply-To: <20141119192725.25314.53729@quantum>
References: <5453C8A7.6080502@samsung.com> <546C457C.6030901@samsung.com>
 <20141119192725.25314.53729@quantum>
Message-ID: <546F57F4.7070400@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/20/14 04:27, Mike Turquette wrote:
> Quoting Kukjin Kim (2014-11-18 23:23:40)
>> On 11/01/14 02:36, Sylwester Nawrocki wrote:
>>> Hi Mike,
>>>
>> Hi Mike,
>>
>>> I've collected Exynos clk patches in this pull request, as Tomasz has
>>> been busy recently. 
>>> This includes addition of clock controller drivers for Exynos4415 and 
>>> Exynos7 SoCs and related refactoring of the Samsung common clk API. 
>>>
>>> As I mentioned in my other e-mail, it might be sensible to put these 
>>> patches into a separate topic branch, so Kukjin can pull it as 
>>> a dependency for the related dts changes.
>>>
>> As Sylwester suggested, can you please provide a topic branch for
>> samsung tree so that I can apply regarding DT changes such as exynos
>> 4415 and exynos7...
> 
> A topic branch already exists:
> 
> git://linuxtv.org/snawrocki/samsung.git for-v3.19/exynos-clk
> 
> ;-)
> 
> I've pulled that into clk-next towards 3.19. Please pull the same branch
> into the samsung tree as a dependency.
> 

Thanks, I've merged the branch into samsung tree. Please make sure the
branch will not be rebased :)

- Kukjin
