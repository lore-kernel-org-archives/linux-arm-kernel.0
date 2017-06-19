From: olof@lixom.net (Olof Johansson)
Date: Sun, 18 Jun 2017 21:01:26 -0700
Subject: [GIT PULL 2/4] firmware: tegra: Changes for v4.13-rc1
In-Reply-To: <20170616081306.11505-2-thierry.reding@gmail.com>
References: <20170616081306.11505-1-thierry.reding@gmail.com>
 <20170616081306.11505-2-thierry.reding@gmail.com>
Message-ID: <20170619040126.GE30022@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 16, 2017 at 10:13:04AM +0200, Thierry Reding wrote:
> Hi ARM SoC maintainers,
> 
> The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:
> 
>   Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.13-firmware
> 
> for you to fetch changes up to cd307124ad9bb01019920c2053696218d161f4a1:
> 
>   firmware: tegra: Fix locking bugs in BPMP (2017-06-14 17:17:32 +0200)
> 
> Thanks,
> Thierry
> 
> ----------------------------------------------------------------
> firmware: tegra: Changes for v4.13-rc1
> 
> This contains a fix for missing semaphore release in error paths as well
> as a bogus error code return in the BPMP firmware implementation.

Merged, thanks.


-Olof
