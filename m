From: amit.kucheria@canonical.com (Amit Kucheria)
Date: Tue, 13 Jul 2010 17:39:06 +0300
Subject: [PATCH 0/3]Add imx51_3ds platform support
In-Reply-To: <1279026162-6634-1-git-send-email-jason77.wang@gmail.com>
References: <1279026162-6634-1-git-send-email-jason77.wang@gmail.com>
Message-ID: <20100713143906.GB6727@matterhorn.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 Jul 13, Jason Wang wrote:
> part3:
> 
>  [PATCH 1/3] mx51_3ds: Add support for the imx51 3-stack board
>  [PATCH 2/3] mx51: add imx_keypad device definition for mx51 platforms
>  [PATCH 3/3] mx51_3ds: add keypad support on 3ds platform
>  This patchset will add imx51_3ds platform in the linux kernel,
>  These 3 patches are generated based off imx-for-2.6.36 branch,
>  and passed build test.

I think the 3ds support is clean enough for merging now.

Acked-by: Amit Kucheria <amit.kucheria@canonical.com>

>  But currently in imx-for-2.6.36 branch, there is a recently applied
>  patch which will affect all imx gpio chained irqs. The lan driver
>  on imx51_3ds can't raise irq(through gpio) because of this potential
>  issue. I generate the following patch to fix it.
>  [PATCH] imx: move gpio init after to irq init

Acked separately.

-- 
----------------------------------------------------------------------
Amit Kucheria, Kernel Engineer || amit.kucheria at canonical.com
----------------------------------------------------------------------
