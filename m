From: olof@lixom.net (Olof Johansson)
Date: Sun, 25 Nov 2012 23:53:23 -0800
Subject: [GIT PULL 1/3] Samsung devel-2 for v3.8
In-Reply-To: <10d601cdc91b$1a5e73b0$4f1b5b10$%kim@samsung.com>
References: <10d601cdc91b$1a5e73b0$4f1b5b10$%kim@samsung.com>
Message-ID: <20121126075323.GF9580@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kgene,

On Fri, Nov 23, 2012 at 10:37:30AM +0900, Kukjin Kim wrote:
> Hi Arnd, Olof
> 
> Here is second Samsung development patches for v3.8.

Please start sorting your branches more. When someone sends in a large
"devel" branch, it doesn't fit our tree organization very well. The
branch below contains fixes, new features and cleanups all in one branch.

> This includes properly enabling PM support and UART3 DEBUG_LL for exynos5
> and CAMIF for s3c24xx/s3c64xx.

"Properly enabling PM support" sounds like worthy of a branch on its own,
for example.



-Olof
