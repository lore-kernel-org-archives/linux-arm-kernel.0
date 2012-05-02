From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 2 May 2012 15:15:43 +0000
Subject: [GIT PULL] defconfig updates for 3.5
In-Reply-To: <20120502083442.GV4141@pengutronix.de>
References: <20120502083442.GV4141@pengutronix.de>
Message-ID: <201205021515.43557.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 02 May 2012, Sascha Hauer wrote:
> Hi Arnd, Olof,
> 
> Please pull the following i.MX defconfig updates for 3.5
> 
> 
> The following changes since commit 66f75a5d028beaf67c931435fdc3e7823125730c:
> 
>   Linux 3.4-rc4 (2012-04-21 14:47:52 -0700)
> 
> are available in the git repository at:
> 
>   git://git.pengutronix.de/git/imx/linux-2.6.git tags/imx-defconfig
> 
> for you to fetch changes up to d86a3480543941344625d1c71aa70510d01f7b11:
> 
>   ARM: imx_v6_v7_defconfig: Add SPI NOR support (2012-04-27 12:17:50 +0200)

Applied to a new next/defconfig branch. Let's see of this topic branch
catches on with the other maintainers. If this ends up being the only
pull request for defconfigs, we can just merge it into another branch
before sending it upstream.

	Arnd
