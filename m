From: olof@lixom.net (Olof Johansson)
Date: Wed, 19 Apr 2017 06:17:55 -0700
Subject: [GIT PULL 3/4] soc/tegra: Core SoC changes for v4.12-rc1
In-Reply-To: <20170406231020.32048-3-thierry.reding@gmail.com>
References: <20170406231020.32048-1-thierry.reding@gmail.com>
 <20170406231020.32048-3-thierry.reding@gmail.com>
Message-ID: <20170419131755.GC29219@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 07, 2017 at 01:10:19AM +0200, Thierry Reding wrote:
> Hi ARM SoC maintainers,
> 
> The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:
> 
>   Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.12-soc
> 
> for you to fetch changes up to 1fd09e5d884a5ff4060948e0cf8f5d7eed16e936:
> 
>   soc/tegra: Add initial flowctrl support for Tegra132/210 (2017-04-04 15:52:31 +0200)
> 
> Thanks,
> Thierry
> 
> ----------------------------------------------------------------
> soc/tegra: Core SoC changes for v4.12-rc1
> 
> This contains PMC support for Tegra186 as well as a proper driver for
> the flow controller found on SoCs up to Tegra210. This also turns the
> fuse driver into an explicitly non-modular driver.

Merged, thanks!


-Olof
