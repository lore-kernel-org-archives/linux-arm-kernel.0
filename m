From: olof@lixom.net (Olof Johansson)
Date: Thu, 20 Dec 2012 08:09:21 -0800
Subject: [GIT PULL 2/2] Samsung fixes-audio part for v3.8-rc1
In-Reply-To: <008501cdde16$8081a800$8184f800$@samsung.com>
References: <008501cdde16$8081a800$8184f800$@samsung.com>
Message-ID: <20121220160921.GE1034@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 19, 2012 at 10:27:26AM -0800, Kukjin Kim wrote:
> Arnd, Olof
> 
> This is for fix the following build error in dev-audio.c on current Samsung
> platforms :-(
> 
> arch/arm/mach-exynos/dev-audio.c:58:4: error: unknown field 'src_clk'
> specified in initializer
> arch/arm/mach-exynos/dev-audio.c:58:4: warning: initialization makes integer
> from pointer without a cast [enabled by default]
> arch/arm/mach-exynos/dev-audio.c:58:4: warning: (near initialization for
> 'i2sv5_pdata.type.i2s.idma_addr') [enabled by default]
> arch/arm/mach-exynos/dev-audio.c:91:4: error: unknown field 'src_clk'
> specified in initializer
> arch/arm/mach-exynos/dev-audio.c:91:4: warning: initialization makes integer
> from pointer without a cast [enabled by default]
> arch/arm/mach-exynos/dev-audio.c:91:4: warning: (near initialization for
> 'i2sv3_pdata.type.i2s.idma_addr') [enabled by default]
> 
> Actually, Pdma's patches were in my tree before release v3.7 but I was
> holding on because I needed to check about regarding audio driver part.
> Anyway, this is required to fix the problem.
> 
> If any problems, please kindly let me know.
> 
> Thanks.
> 
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
> 
> The following changes since commit 74779e22261172ea728b989310f6ecc991b57d62:
> 
>   Merge tag 'for-3.8-rc1' of git://gitorious.org/linux-pwm/linux-pwm
> (2012-12-19 08:19:07 -0800)
> 
> are available in the git repository at:
> 
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> v3.8-samsung-fixes-audio


Pulled.


-Olof
