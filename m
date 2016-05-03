From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 2 May 2016 17:02:48 -0700
Subject: [GIT PULL] clk: tegra: Changes for v4.7-rc1
In-Reply-To: <1461945596-24090-1-git-send-email-thierry.reding@gmail.com>
References: <1461945596-24090-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <20160503000248.GB3492@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/29, Thierry Reding wrote:
> Hi Michael, Stephen,
> 
> The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:
> 
>   Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.7-clk
> 
> for you to fetch changes up to 2690e912644e610854c4c3b23d0a0daec9d030ca:
> 
>   clk: tegra: dfll: Reformat CVB frequency table (2016-04-28 12:41:54 +0200)
> 
> Note that the first patch is this pull request is a dependency for a
> larger series that will have to go in through the ARM-SoC tree in order
> to properly handle the dependencies.
> 

Thanks. Pulled.

Are there any thoughts on making that hw control stuff more
generic? Perhaps using something like power domains to do that
instead of having drivers cross-call to the clk driver with
custom tegra APIs?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
