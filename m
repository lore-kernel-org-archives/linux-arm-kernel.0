From: ta.omasab@gmail.com (Thomas Abraham)
Date: Mon, 20 Oct 2014 17:18:45 +0530
Subject: [PATCH v11 0/6] cpufreq: use generic cpufreq drivers for exynos
 platforms
In-Reply-To: <5444F38A.1000101@gmail.com>
References: <1413805281-6269-1-git-send-email-thomas.ab@samsung.com>
 <5444F38A.1000101@gmail.com>
Message-ID: <CAJuA9ajv_e0FriiPL0aHWLv7+AoZAF2E+G-0r6UGC6RzxM_wmA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

On Mon, Oct 20, 2014 at 5:05 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> On 20.10.2014 13:41, Thomas Abraham wrote:
>> Changes since v10:
>> - Rebased on top of v3.18-rc1
>>
>> This patch series removes the use of Exynos4210 and Exynos5250 specific cpufreq
>> drivers and enables the use of cpufreq-dt driver for these platforms. This
>> series also enables cpufreq support for Exynos5420 using arm_big_little cpufreq
>> driver.
>>
>> This patch series is based and tested on v3.18-rc1 and depends on the patch
>> - "clk: exynos4: remove duplicate div_core2 divider clock instantiation"
>>   (http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg34859.html)
>>   This patch has been merged in "arm-soc/samsung/dt3" branch of arm-soc tree.
>>
>
> That patch actually went through clock tree, but it doesn't matter,
> because AFAIK all the dependencies for this series are already in
> 3.18-rc1. I'll try to apply it in next days

Thanks. The patch "clk: exynos4: remove duplicate div_core2 divider
clock instantiation" is not available in 3.18-rc1. So for testing, I
picked this patch from samsung/dt3 branch from arm-soc tree.

Regards,
Thomas.


>
> Best regards,
> Tomasz
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
