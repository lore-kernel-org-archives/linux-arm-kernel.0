From: ta.omasab@gmail.com (Thomas Abraham)
Date: Sun, 14 Sep 2014 19:15:14 +0530
Subject: [PATCH 00/14] Support 64bit Cortex A57 based Exynos7 SoC
In-Reply-To: <54142324.600@gmail.com>
References: <1409132660-1898-1-git-send-email-ch.naveen@samsung.com>
 <53FDC25A.2010806@samsung.com> <54142324.600@gmail.com>
Message-ID: <CAJuA9ahjdZw23CyEJBO8wwypR0QCf=4+QXB1LXUSzc5rRoDe_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

On Sat, Sep 13, 2014 at 4:27 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> On 27.08.2014 13:34, Tomasz Figa wrote:
>> Hi Naveen,
>>
>> On 27.08.2014 11:44, Naveen Krishna Chatradhi wrote:
>>> This patchset supports new Exynos7 Samsung SoC based on Cortex-A57.
>>> Exynos7 is a System-On-Chip (SoC) that is based on 64-bit
>>> ARMv8 RISC processor.
>>
>> A general issue with this series is that it introduces a very generic
>> name for a very specific single SoC. We remember exactly the same cases
>> for Exynos4 (original name used for Exynos5250) and Exynos5 (Exynos5250)
>> and we should have learned that it is better to use a specific name
>> first and only then try to make things common if it turns out to be
>> appropriate.
>
> Any comments on this?

The name of the SoC is Exynos7 and so all these patches are using
Exynos7 in dt compatible string and file names. If there are any
variants of Exynos7 SoC in future, support those variants will be
based on what is already merged for Exynos7 SoC. There is no specific
generalization targeted in this series by using Exynos7 name.

Thanks,
Thomas.

> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
