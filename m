From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 10 Jun 2014 15:07:10 +0200
Subject: [PATCH] ARM: exynos: mark machine descriptor functions static
In-Reply-To: <1401771456-6101-1-git-send-email-olof@lixom.net>
References: <1401771456-6101-1-git-send-email-olof@lixom.net>
Message-ID: <539702FE.5030902@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On 03.06.2014 06:57, Olof Johansson wrote:
> There's no reason to export these functions, and I have no idea why
> they have over time ended up in the header file. As a result, none of
> the checker tools caught it (i.e. sparse was silent on it).
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>
> ---
> 
> I'm guessing with all the churn right now this might not apply, so it
> might need manual application around -rc1.
> 
> There's definitely room for more cleanup in common.h.
> 
>  arch/arm/mach-exynos/common.h |    6 ------
>  arch/arm/mach-exynos/exynos.c |   10 +++++-----
>  2 files changed, 5 insertions(+), 11 deletions(-)
> 

Similar patch and few other clean-up patches were posted some time ago
on the list as a part of PMU rework series, but somehow got missed. They
can be applied independently from rest of the series which is still
under discussion.

Best regards,
Tomasz
