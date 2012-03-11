From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sun, 11 Mar 2012 00:09:56 -0800
Subject: [GIT PULL 4/4] Samsung devel-dma for v3.4
In-Reply-To: <20120310182149.GA656@quad.lixom.net>
References: <4F5B7CA7.2010604@samsung.com>
 <20120310182149.GA656@quad.lixom.net>
Message-ID: <4F5C5DD4.60309@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/10/12 10:21, Olof Johansson wrote:
> On Sat, Mar 10, 2012 at 08:09:11AM -0800, Kukjin Kim wrote:
>> Hi Arnd, Olof,
>>
>> This is for Samsung dma stuff for v3.4 and depends on following:
>>    next/cleanup-use-static
>>    next/cleanup-exynos-clock
>>
>> Please pull from:
>
>> git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
>> next/devel-samsung-dma
>>
>> And conflicts will be happened in clock part. Here is my preferred
>> resolution. The mach-exynos/clock.c can be removed with following:
>>
>> arch/arm/mach-exynos/exynos-clock4.c
>
> Hi,
>
> given my feedback on the cleanup-exynos-clock pull request, I'm holding off on
> this one waiting on you to do the resolution of the conflicts. :-)
>
Yes, your suggestion can avoid bad conflicts.

Olof, let me rebase this on top of new cleanup-exynos-clock you 
suggested and will send a new pull request.

Thanks.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
