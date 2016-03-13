From: olof@lixom.net (Olof Johansson)
Date: Sat, 12 Mar 2016 17:12:10 -0800
Subject: [GIT PULL 1/2] ARM: EXYNOS: mach/soc changes for v4.6, 2nd
In-Reply-To: <1456445103-23314-1-git-send-email-k.kozlowski@samsung.com>
References: <1456445103-23314-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20160313011210.GJ17502@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 26, 2016 at 09:05:02AM +0900, Krzysztof Kozlowski wrote:
> Hi Arnd, Kevin and Olof,
> 
> 
> Second pull request for v4.6 with mach/soc changes. This does
> not contain any external dependencies.
> 
> It includes movement of PMU code to separate driver (drivers/soc) but
> it does not have commits doing the same for the SROM controller driver
> (that part I will send separately).
> 
> 
> Kind regards,
> Krzysztof
> 
> 
> Cc: Pankaj Dubey <pankaj.dubey@samsung.com>
> 
> 
> 
> The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:
> 
>   Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-soc-4.6-2

Hi,

Apologies for the long latency here.

I should probably merge this into a late/* branch, but for now I've taken it
into next/soc because I feel guilty. :-)


-Olof
