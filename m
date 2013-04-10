From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Wed, 10 Apr 2013 09:18:42 +0530
Subject: [GIT PULL 04/10] clk-exynos for v3.10
In-Reply-To: <201304092231.18314.arnd@arndb.de>
References: <51630A02.4080905@samsung.com> <201304092231.18314.arnd@arndb.de>
Message-ID: <CAK9yfHzMOmrRMKdc2fUJHnbrOC_-=AR3BnHBDjtvPeinvxOcLg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 April 2013 02:01, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 08 April 2013, Kukjin Kim wrote:
>> The following changes since commit 07961ac7c0ee8b546658717034fe692fd12eefa9:
>>
>>    Linux 3.9-rc5 (2013-03-31 15:12:43 -0700)
>>
>> are available in the git repository at:
>>
>>    git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
>> tags/clk-exynos-for-v3.10
>>
>> for you to fetch changes up to da821eb7d42935b0f7056d98c75fd1150f6636f4:
>>
>>    Merge commit 'v3.9-rc5' into next/clk-exynos (2013-04-09 01:10:13 +0900)
>>
>> ----------------------------------------------------------------
>>
>> add suppport common clock framework for exynos
>
> I got a build warning, probably because of this patch:


IIRC, the patch at [1] was supposed to fix the build warning. Kukjin
had mentioned it was applied [1].

[1] https://patchwork.kernel.org/patch/2010691/


-- 
With warm regards,
Sachin
