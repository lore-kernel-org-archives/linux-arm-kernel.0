From: olof@lixom.net (Olof Johansson)
Date: Fri, 19 Apr 2013 14:17:53 -0700
Subject: [PATCH] ARM: exynos: restore mach/regs-clock.h for exynos5
In-Reply-To: <201304192310.26041.arnd@arndb.de>
References: <201304191554.29679.arnd@arndb.de>
 <201304192059.38606.arnd@arndb.de> <5171AB10.5070702@gmail.com>
 <201304192310.26041.arnd@arndb.de>
Message-ID: <CAOesGMg=ywanoJTeTZwcS-AxUYq00hD9NZCKeN=3_iksSm8QVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 19, 2013 at 2:10 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> Commit 6e6aac75 "ARM: EXYNOS: Migrate clock support to common
> clock framework" from Thomas Abraham removed the Exynos5 specific
> register definitions as they were unused at the time, but the
> cpufreq driver actually still uses them.
>
> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Cc: Tomasz Figa <t.figa@samsung.com>
> Cc: Thomas Abraham <thomas.abraham@linaro.org>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 8<----
>
> I'd apply this one on next/drivers to fix the build error, unless
> someone has concerns.

Acked-by: Olof Johansson <olof@lixom.net>
