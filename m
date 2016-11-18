From: olof@lixom.net (Olof Johansson)
Date: Thu, 17 Nov 2016 16:38:18 -0800
Subject: [GIT PULL] i.MX fixes for 4.9, 2nd round
In-Reply-To: <20161115024353.GT3310@dragon>
References: <20161115024353.GT3310@dragon>
Message-ID: <20161118003818.GD8578@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 15, 2016 at 10:43:55AM +0800, Shawn Guo wrote:
> The following changes since commit 4edd601c5a9c5094daa714e65063e623826f3bcc:
> 
>   ARM: imx: mach-imx6q: Fix the PHY ID mask for AR8031 (2016-10-24 21:26:01 +0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-fixes-4.9-2
> 
> for you to fetch changes up to e3c9d9d6ebfeeeee29c6240e1b5978d40d31d21f:
> 
>   ARM: dts: imx53-qsb: Fix regulator constraints (2016-11-05 16:18:16 +0800)
> 
> ----------------------------------------------------------------
> i.MX fixes for 4.9, 2nd round:
> 
> It fixes a boot failure on imx53-qsb board with a DA9053 PMIC, which is
> caused by the regulator core change, commit fa93fd4ecc9c ("regulator:
> core: Ensure we are at least in bounds for our constraints").

Merged, thanks!


-Olof
