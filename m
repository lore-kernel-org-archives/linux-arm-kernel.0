From: olof@lixom.net (Olof Johansson)
Date: Sat, 29 Dec 2012 21:24:53 -0800
Subject: [PATCH v3 0/5] ARM: Exynos: Enable device tree support for MCT
 controller
In-Reply-To: <1356814238-23895-1-git-send-email-thomas.abraham@linaro.org>
References: <1356814238-23895-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <20121230052453.GA20903@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 29, 2012 at 12:50:33PM -0800, Thomas Abraham wrote:
> Changes since v2:
> - Rebased to linux 3.8-rc1
> 
> Changes since v1:
> - Includes changes suggested by Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
> 
> This patch series adds device tree support for Exynos4/5 MCT controller.
> This patch series has been tested on Exynos4210 based Origen board, Exynos4412
> based Origen board and Exynos5250 based SMDK board.

Hi,

Nice cleanups -- no specific comments on those at this time. But
this is a good time to move the MCT driver out of arch/arm and into
drivers/clocksource. Can you please do that in this series as well,
please?


Thanks,

-Olof
