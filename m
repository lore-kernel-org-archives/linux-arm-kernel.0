From: olof@lixom.net (Olof Johansson)
Date: Thu, 13 Aug 2015 11:18:14 +0200
Subject: [GIT PULL 4/5] Samsung 2nd DT updates for v4.3
In-Reply-To: <55C069D5.1050409@kernel.org>
References: <55C069D5.1050409@kernel.org>
Message-ID: <20150813091814.GA30160@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 04, 2015 at 04:29:25PM +0900, Kukjin Kim wrote:
> Hi Arnd, Olof, Kevin
> 
> This 2nd DT update branch is based tags/samsung-dt-1 +
> v4.3-topic/clk-samsung branch because of dependency to support generic
> cpufreq driver. Please pull.
> 
> Thanks,
> Kukjin
> 
> 
> The following changes since commit e4a39d904c3c3e4855287b7325306289ff044b06:
> 
>   Merge branch 'v4.3-topic/clk-samsung' into v4.3-next/dt-samsung-2
> (2015-07-24 12:54:00 +0900)
> 
> are available in the git repository at:
> 
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> tags/samsung-dt-2

"clk: exynos5250: add cpu clock configuration data and instantiate cpu
clock" is applied twice, once to your own branch, and once merged in
from Mike's branch. That doesn't look right.

Can you please respin? Thanks.


Thanks,

-Olof
