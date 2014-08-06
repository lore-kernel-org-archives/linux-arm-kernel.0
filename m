From: punit.agrawal@arm.com (Punit Agrawal)
Date: Wed, 06 Aug 2014 14:41:26 +0100
Subject: [PATCH 0/2] Convert exynos PPMU driver to be built as module
In-Reply-To: <1405692594-19352-1-git-send-email-punit.agrawal@arm.com> (Punit
 Agrawal's message of "Fri, 18 Jul 2014 15:09:52 +0100")
References: <1405692594-19352-1-git-send-email-punit.agrawal@arm.com>
Message-ID: <9hhvbq54tx5.fsf@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Punit Agrawal <punit.agrawal@arm.com> writes:

> Hi,
>
> There's no reason why the exynos PPMU can't be built as a module
> except you need -
>
> - The first patch exports the functions that are needed to build
> devfreq drivers as modules.
>
> - The second patch then converts the exynos PPMU devfreq driver to be
>   built as a module.
>

Ping!

> Compile tested only.
>
> Thanks
>
> Punit Agrawal (1):
>   PM / devfreq: exynos: Enable building exynos PPMU as module
>
> ?rjan Eide (1):
>   PM / devfreq: Export helper functions for drivers
>
>  drivers/devfreq/Kconfig              |    2 +-
>  drivers/devfreq/devfreq.c            |    3 +++
>  drivers/devfreq/exynos/exynos_ppmu.c |    3 +++
>  3 files changed, 7 insertions(+), 1 deletion(-)
