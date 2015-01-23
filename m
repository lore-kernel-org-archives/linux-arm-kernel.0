From: olof@lixom.net (Olof Johansson)
Date: Fri, 23 Jan 2015 14:55:47 -0800
Subject: [GIT PULL 3/4] ARM: tegra: Core code changes for v3.20
In-Reply-To: <1422028800-759-3-git-send-email-thierry.reding@gmail.com>
References: <1422028800-759-1-git-send-email-thierry.reding@gmail.com>
 <1422028800-759-3-git-send-email-thierry.reding@gmail.com>
Message-ID: <20150123225547.GT20896@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 23, 2015 at 04:59:59PM +0100, Thierry Reding wrote:
> Hi ARM SoC maintainers,
> 
> The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:
> 
>   Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-3.20-soc
> 
> for you to fetch changes up to 3568df3d31d62b4368830cc6aac868cecdefd187:
> 
>   soc: tegra: Add thermal reset (thermtrip) support to PMC (2015-01-23 16:20:49 +0100)
> 
> Thanks,
> Thierry
> 
> ----------------------------------------------------------------
> ARM: tegra: Core code changes for v3.20
> 
> This contains a couple of preparatory patches for 64-bit support. A new
> feature is implemented in the power-management controller which allows
> it to switch off the SoC if it overheats.

Merged.


-Olof
