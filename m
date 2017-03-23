From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu, 23 Mar 2017 13:58:30 +0200
Subject: [GIT PULL] Immutable branch between MFD and PHY due for the v4.12
 merge window
In-Reply-To: <20170323105110.26w3g6jxrlgdtka7@dell>
References: <20170314164653.15771-1-krzk@kernel.org>
 <20170314164653.15771-5-krzk@kernel.org>
 <20170323105110.26w3g6jxrlgdtka7@dell>
Message-ID: <CAJKOXPdd5H-oBnz74ay-oEtUqrQ-GZwgNoaf_cD9nOUHHRHWrg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 23, 2017 at 12:51 PM, Lee Jones <lee.jones@linaro.org> wrote:
> Enjoy!
>
> The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:
>
>   Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-phy-v4.12
>
> for you to fetch changes up to f7f6c060547c51691f9b943e6c33f63675c1a0a9:
>
>   mfd: exynos-lpass: Use common soc/exynos-regs-pmu.h header (2017-03-23 10:47:27 +0000)
>
> ----------------------------------------------------------------
> Immutable branch between MFD and PHY due for the v4.12 merge window
>
> ----------------------------------------------------------------
> Krzysztof Kozlowski (1):
>       mfd: exynos-lpass: Use common soc/exynos-regs-pmu.h header
>
>  drivers/mfd/exynos-lpass.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thanks.

Kishon,
This is the dependency for last patch in v4 of:
https://www.spinics.net/lists/arm-kernel/msg568609.html

Everything else is acked and ready for you to apply.

Any comments?

Best regards,
Krzysztof
