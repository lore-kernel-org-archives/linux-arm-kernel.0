From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 19 Jul 2014 09:43:32 +0900
Subject: [GIT PULL] Samsung fixes-4 for v3.16
In-Reply-To: <53C9B952.6010000@samsung.com>
References: <53C9AF23.6030007@samsung.com>
 <CAOesGMgt50Ut8qv+ifDHoSQCBV4NNu-tx6B_t=T7D5SHVx0XMg@mail.gmail.com>
 <53C9B952.6010000@samsung.com>
Message-ID: <53C9BF34.2030903@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/19/14 09:18, Kukjin Kim wrote:
> On 07/19/14 09:12, Olof Johansson wrote:
>> On Fri, Jul 18, 2014 at 4:34 PM, Kukjin Kim<kgene.kim@samsung.com> wrote:
>>> Hi,
>>>
>>> This is a regression for v3.16 so please take this in -rc.
>>>
>>> Thanks,
>>> Kukjin
>>>
>>> The following changes since commit
>>> 1795cd9b3a91d4b5473c97f491d63892442212ab:
>>>
>>> Linux 3.16-rc5 (2014-07-13 14:04:33 -0700)
>>>
>>> are available in the git repository at:
>>>
>>> git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
>>> tags/samsung-fixes-4
>>>
>>> for you to fetch changes up to 4e3a498d6fc438d8c203c51aadc6ca8fb47b0577:
>>>
>>> ARM: EXYNOS: Fix core ID used by platsmp and hotplug code (2014-07-16
>>> 02:59:18 +0900)
>>
>> This is based on a newer branch than our current fixes. So I've cherry
>> picked the patch instead of merged the branch -- if you have the
>> branch in linux-next you should remove it.
>>
> OK, I will.
>
BTW, other pm related branches in my tree have dependencies with the 
change so I just reverted that in my -next.

If any problems, please let me know.

Thanks,
Kukjin
