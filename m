From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 25 Mar 2013 21:52:30 +0000
Subject: [GIT PULL] msm fix for 3.9 -- timer
In-Reply-To: <8ya8v5b88aj.fsf@huya.qualcomm.com>
References: <8ya8v5b88aj.fsf@huya.qualcomm.com>
Message-ID: <201303252152.30806.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 25 March 2013, David Brown wrote:
> The following changes since commit f6161aa153581da4a3867a2d1a7caf4be19b6ec9:
> 
>   Linux 3.9-rc2 (2013-03-10 16:54:19 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/davidb/linux-msm.git tags/msm-fix-3.9
> 
> for you to fetch changes up to 4080d2d11a2d572228c2b8d02406e997b87ba6a5:
> 
>   ARM: msm: Stop counting before reprogramming clockevent (2013-03-22 10:45:39 -0700)
> 
> ----------------------------------------------------------------
> This fix is intended for v3.9.  It fixes a timer bug on MSM targets
> that cause system hangs.

Pulled into the fixes branch. You just missed 3.9-rc5 as Linus pulled the
branch today, but it I will send it for -rc6.

Should the patch be marked for backports to stable?

	Arnd
