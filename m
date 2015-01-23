From: olof@lixom.net (Olof Johansson)
Date: Fri, 23 Jan 2015 14:53:36 -0800
Subject: [GIT PULL 2/4] ARM: tegra: Default configuration changes for v3.20
In-Reply-To: <1422028800-759-2-git-send-email-thierry.reding@gmail.com>
References: <1422028800-759-1-git-send-email-thierry.reding@gmail.com>
 <1422028800-759-2-git-send-email-thierry.reding@gmail.com>
Message-ID: <20150123225336.GS20896@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 23, 2015 at 04:59:58PM +0100, Thierry Reding wrote:
> Hi ARM SoC maintainers,
> 
> The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:
> 
>   Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-3.20-defconfig
> 
> for you to fetch changes up to fe07e48964c6f21020eeeb7f83e35a5bf1977a65:
> 
>   ARM: tegra: Regenerate defconfig based on v3.19-rc1 (2015-01-06 14:10:57 +0100)

We usually don't do this for all configs on all releases -- just drop
them when you revisit the file for other reasons some other time. That
being said, no harm as long as only a few people do it every release
(i.e. we don't want this to creep up on diffstats).

Merged into next/defconfig.


-Olof
