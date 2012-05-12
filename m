From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sun, 13 May 2012 08:45:01 +0900
Subject: [GIT PULL] Samsung fixes for v3.4
In-Reply-To: <CAOesGMj8PgGRmdQQSnJmAurL1uYM2exxDaeTTWHVe9JQR0zQ-w@mail.gmail.com>
References: <4FAED92C.4090103@samsung.com>
 <CAOesGMj8PgGRmdQQSnJmAurL1uYM2exxDaeTTWHVe9JQR0zQ-w@mail.gmail.com>
Message-ID: <4FAEF5FD.6070904@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/13/12 07:29, Olof Johansson wrote:
> Hi,
>
>
> Since we are _so_ close to release, I am going to be picky about what
> kind of patches we're going to accept for 3.4. See below.
>
> On Sat, May 12, 2012 at 2:42 PM, Kukjin Kim<kgene.kim@samsung.com>  wrote:
>
>
>> Changhwan Youn (1):
>>       ARM: EXYNOS: fix the hotplug for Cortex-A15
>
> This is a feature, not a bug fix -- cpu hotplug has never worked for
> A15 based on the patch description. So per definition it's 3.5
> material.
>
Hmm, in this case, IMHO, it's hard to say whether it is not a bug fix 
because in current mach-exynos/ problem happens during cpu hotplug on 
exynos5250 without that...But, OK it will be queued for v3.5.

> Also, I'll send out a comment on the patch itself, it shouldn't check
> for SoC version, it should check for core version. See separate email
> shortly.
>
OK, thanks for your comments and will update it even though checking SoC 
version is enough in mach-exynos/ :)

>> Jose Miguel Goncalves (1):
>>       ARM: SAMSUNG: Fix for S3C2412 EBI memory mapping
>
> This has been broken since 2.6.32. Please queue it up in a fixes
> branch for the 3.5 merge window instead, it doesn't qualify as a
> recent regression and thus we shouldn't try to squeeze it in before
> the merge window closes.
>
OK, I agree.

>> Kukjin Kim (1):
>>       ARM: EXYNOS: fix ctrlbit for exynos5_clk_pdma1
>>
>> Marek Szyprowski (1):
>>       ARM: EXYNOS: use s5p-timer for UniversalC210 board
>
> Those two look appropriate. Please send a new pull request with those two.
>
I sent just now.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
