From: olof@lixom.net (Olof Johansson)
Date: Tue, 22 Dec 2015 11:53:18 -0800
Subject: [GIT PULL 2/5] memory: tegra: Changes for v4.5-rc1
In-Reply-To: <1450356639-7758-2-git-send-email-thierry.reding@gmail.com>
References: <1450356639-7758-1-git-send-email-thierry.reding@gmail.com>
 <1450356639-7758-2-git-send-email-thierry.reding@gmail.com>
Message-ID: <20151222195318.GG30172@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 17, 2015 at 01:50:36PM +0100, Thierry Reding wrote:
> Hi ARM SoC maintainers,
> 
> The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:
> 
>   Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.5-memory
> 
> for you to fetch changes up to e2127ae7a5e80eb53ad431c39145767391da40cd:
> 
>   memory/tegra: Add number of TLB lines for Tegra124 (2015-12-14 16:11:35 +0100)
> 
> Thanks,
> Thierry
> 
> ----------------------------------------------------------------
> memory: tegra: Changes for v4.5-rc1
> 
> This is a single fix to improve performance of the SMMU on Tegra124.

Merged, thanks.


Btw, it's a little confusing when there's [GIT PULL x/5] and we only
see 2-5. I wasn't sure if 1/5 had gotten lost, so I had to go search for
it. Seems like it was destined for the clk tree. It'd be nice if those
were sent outside of the series to avoid confusion in the future.


-Olof
