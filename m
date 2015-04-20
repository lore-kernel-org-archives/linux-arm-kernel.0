From: khilman@kernel.org (Kevin Hilman)
Date: Mon, 20 Apr 2015 14:07:33 -0700
Subject: [PATCH 0/4] cpufreq: use generic cpufreq drivers for Exynos5250
 platform
In-Reply-To: <1428946441-17058-1-git-send-email-b.zolnierkie@samsung.com>
 (Bartlomiej Zolnierkiewicz's message of "Mon, 13 Apr 2015 19:33:57
 +0200")
References: <1428946441-17058-1-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <7h1tjeh5ka.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com> writes:

> Hi,
>
> This patch series removes the use of Exynos5250 specific support
> from exynos-cpufreq driver and enables the use of cpufreq-dt driver
> for this platform.  The exynos-cpufreq driver itself is also removed
> as it is no longer used/needed after Exynos5250 support removal.
>
> This patch series has been tested on Exynos5250 based Arndale board.
>
> Depends on:
> - next-20150330 branch of linux-next kernel tree
> - "[PATCH 0/6] cpufreq: use generic cpufreq drivers for Exynos4210
>   platform" [1]
> - "[PATCH 0/6] cpufreq: use generic cpufreq drivers for Exynos4x12
>   platform" [2]
> - "[PATCH] cpufreq: exynos: remove dead ->need_apll_change method" [3]

Any chance you could prepare a branch with all the dependencies for easy
testing?

Also, The previous version from Thomas was v12, and this one is neither
versioned nor has any reference to what may have changed since that
version.  Also, on v12, I had several comments[1] and wonder if they've
been addressed.

Kevin

[1] http://article.gmane.org/gmane.linux.power-management.general/53494/match=patch+v12+0+6+use+generic+cpufreq
