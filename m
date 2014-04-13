From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Mon, 14 Apr 2014 01:30:38 +0200
Subject: [PATCH V2 0/3] Add PMU and S2R support for exynos5420
In-Reply-To: <CAGm_ybhWjc7=OUJ5BTvQ-K6S_RwYVgGV8+vi6iUgKEJb0qSymw@mail.gmail.com>
References: <1395900785-11334-1-git-send-email-vikas.sajjan@samsung.com>
 <CAGm_ybhWjc7=OUJ5BTvQ-K6S_RwYVgGV8+vi6iUgKEJb0qSymw@mail.gmail.com>
Message-ID: <534B1E1E.7040001@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vikas,

Will review on Tuesday, when back at work. Same for the other series 
from you.

Best regards,
Tomasz

On 11.04.2014 15:17, Vikas Sajjan wrote:
>   Hi,
>
>   Any comments on this series.
>
> On Thu, Mar 27, 2014 at 11:43 AM, Vikas Sajjan <vikas.sajjan@samsung.com> wrote:
>> rebased on kgene tree for-next branch
>> https://git.kernel.org/cgit/linux/kernel/git/kgene/linux-samsung.git/log/?h=for-next
>>
>> changes since v1:
>>          - Addressed comments from Tomasz figa.
>>          - restructured/consolidated as per Tomasz figa's PM consolidations for exynos
>>
>> Abhilash Kesavan (1):
>>    ARM: dts: Add node for GPIO keys on SMDK5420
>>
>> Vikas Sajjan (2):
>>    ARM: EXYNOS5: Add PMU settings for exynos5420
>>    ARM: EXYNOS5: Support Suspend-to-RAM on EXYNOS5420
>>
>>   arch/arm/boot/dts/exynos5420-smdk5420.dts    |   11 +
>>   arch/arm/mach-exynos/common.h                |   10 +
>>   arch/arm/mach-exynos/pm.c                    |  148 +++++++++++--
>>   arch/arm/mach-exynos/pmu.c                   |  307 ++++++++++++++++++++++++++
>>   arch/arm/mach-exynos/regs-pmu.h              |  230 +++++++++++++++++++
>>   arch/arm/plat-samsung/include/plat/map-s5p.h |    2 +
>>   drivers/clk/samsung/clk-exynos5420.c         |   32 +++
>>   7 files changed, 722 insertions(+), 18 deletions(-)
>>
>> --
>> 1.7.9.5
>>
