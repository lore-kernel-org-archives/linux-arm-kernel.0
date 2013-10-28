From: olof@lixom.net (Olof Johansson)
Date: Sun, 27 Oct 2013 21:33:11 -0700
Subject: [GIT PULL 1/6] Samsung cleanup for v3.13
In-Reply-To: <526455CB.6050507@samsung.com>
References: <526455CB.6050507@samsung.com>
Message-ID: <20131028043311.GG22890@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 21, 2013 at 07:14:35AM +0900, Kukjin Kim wrote:
> The following changes since commit 4a10c2ac2f368583138b774ca41fac4207911983:
> 
>   Linux 3.12-rc2 (2013-09-23 15:41:09 -0700)
> 
> are available in the git repository at:
> 

> git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> tags/samsung-cleanup
> 
> for you to fetch changes up to ae3c5d74ea0d5e2f1c32c527e5de36c7614525af:
> 
>   ARM: EXYNOS: remove CONFIG_MACH_EXYNOS[4, 5]_DT config options
> (2013-10-21 06:35:47 +0900)

Thanks, pulled into next/cleanup. Trivial add/add conflict when merging
into for-next due to the 64xx DT platform, no big deal.


-Olof
