From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Jun 2013 15:35:51 +0200
Subject: [GIT PULL] Allwinner sunXi platform additions for 3.11, take 2
In-Reply-To: <20130619101045.GA8067@lukather>
References: <20130619101045.GA8067@lukather>
Message-ID: <201306201535.51548.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 19 June 2013, Maxime Ripard wrote:
> Please consider pulling this small pull request of machine changes to
> support the A10s.
> 
> Thanks
> 
> The following changes since commit ec3805e6199649db2a462045a38eb1050c6151aa:
> 
>   ARM: sunxi: irqchip: Update the documentation (2013-05-29 09:39:39 +0200)
> 
> are available in the git repository at:
> 
>   git://github.com/mripard/linux.git tags/sunxi-core-for-3.11-2
> 
> for you to fetch changes up to 81265dfb1ccba0941e54a61c2473befe8c09edc0:
> 
>   ARM: sunxi: Add Allwinner A10s machine compatible (2013-06-16 20:49:30 +0200)
> 

Merged into next/soc as well, thanks!

It ended up in the same branch as the defconfig changes on my end, but
it's good that you sent out separate pull requests anyway, so please
keep doing this in case we decide to do it differently in the future.

	Arnd
