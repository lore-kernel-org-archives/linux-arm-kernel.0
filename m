From: drake@endlessm.com (Daniel Drake)
Date: Fri, 24 Oct 2014 07:18:21 -0600
Subject: [PATCH 2/5] clk: samsung: exynos4415: Add clocks using common
 clock framework
In-Reply-To: <1413775935-17743-2-git-send-email-cw00.choi@samsung.com>
References: <1413775749-17539-1-git-send-email-cw00.choi@samsung.com>
 <1413775935-17743-2-git-send-email-cw00.choi@samsung.com>
Message-ID: <CAD8Lp45F_6UWXx0f2xVGZL+Rgemg2fzkYhnfPdaeaiky0rKPgw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 19, 2014 at 9:32 PM, Chanwoo Choi <cw00.choi@samsung.com> wrote:
> This patch adds the new clock driver of Exynos4415 SoC based on Cortex-A9
> using common clock framework. The CMU (Clock Management Unit) of Exynos4415
> controls PLLs(Phase Locked Loops) and generates system clocks for CPU, buses
> and function clocks for individual IPs.

There seems to be a lot in common here with other exynos4 variants in
clk-exynos4.c. Have you considered just adding support for the 4415 in
the existing driver?

Thanks
Daniel
