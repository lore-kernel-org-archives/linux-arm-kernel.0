From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 09 May 2016 16:10:36 +0200
Subject: [GIT PULL 1/6] i.MX soc updates for 4.7
In-Reply-To: <1462291086-19925-1-git-send-email-shawnguo@kernel.org>
References: <1462291086-19925-1-git-send-email-shawnguo@kernel.org>
Message-ID: <9769216.VIYSu12p0q@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 03 May 2016 23:58:01 Shawn Guo wrote:
> The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:
> 
>   Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-soc-4.7
> 
> for you to fetch changes up to acc98009b87a811f9f815650274a1044474cd167:
> 
>   ARM: imx: always use TWD on IMX6Q (2016-04-12 15:56:55 +0800)
> 
> ----------------------------------------------------------------
> The i.MX SoC updates for 4.7:
>  - Allow TWD to be used on UP kernel, as the PREEMPT-RT and cyclictest
>    shows that TWD has a slightly better performance than i.MX timer.
> 

Pulled into next/soc, thanks!

	Arnd
