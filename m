From: jszhang@marvell.com (Jisheng Zhang)
Date: Thu, 7 Nov 2013 11:13:56 +0800
Subject: [PATCH 0/4] arm: make use of common scu_a9_get_base() interface
In-Reply-To: <1383793720-4643-1-git-send-email-jszhang@marvell.com>
References: <1383793720-4643-1-git-send-email-jszhang@marvell.com>
Message-ID: <20131107111356.7575c85e@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 6 Nov 2013 19:08:33 -0800
Jisheng Zhang <jszhang@marvell.com> wrote:

> Commit e9d6b3358ac35901ccc6a4a5a317670fa469db25 adds common APIs to
> get scu base address from CP15. This patch series connverts some platforms
> to use that interface.

OOPS, sorry, I made an mistake when generating patches. Please ignore this
serials. I'll submit V2 soon

Sorry again.
Jisheng
> 
> Jisheng Zhang (4):
>   arm: highbank: make use of common scu_a9_get_base() interface
>   arm: imx: make use of common scu_a9_get_base() interface
>   arm: prima2: make use of common scu_a9_get_base() interface
>   arm: socfgpa: make use of common scu_a9_get_base() interface
> 
>  arch/arm/mach-highbank/highbank.c | 4 ++--
>  arch/arm/mach-imx/platsmp.c       | 3 +--
>  arch/arm/mach-prima2/platsmp.c    | 3 +--
>  arch/arm/mach-socfpga/socfpga.c   | 4 ++--
>  4 files changed, 6 insertions(+), 8 deletions(-)
> 
