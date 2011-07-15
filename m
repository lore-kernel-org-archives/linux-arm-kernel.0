From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 15 Jul 2011 16:05:31 +0200
Subject: [GIT PULL] more i.MX fixes
In-Reply-To: <20110715092307.GN6069@pengutronix.de>
References: <20110715092307.GN6069@pengutronix.de>
Message-ID: <201107151605.31807.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 July 2011, Sascha Hauer wrote:
> Please pull the following fixes for i.MX. These are orthogonal to
> the branches you already pulled and this are directly based on Linus
> tree.
> 
> Sascha
> 
> The following changes since commit 5dcd07b9f39ca3e9be5bcc387d193fc0674e1c81:
> 
>   Merge git://git.kernel.org/pub/scm/linux/kernel/git/steve/gfs2-2.6-fixes (2011-07-14 10:20:42 -0700)
> 
> are available in the git repository at:
> 
>   git://git.pengutronix.de/git/imx/linux-2.6.git fixes-for-arnd
> 

Hi Sascha,

The fixes all look good, but please rebase them on top of an -rc
release if possible. Pulling this into my tree would make the
master branch base on an arbitrary commit (today's HEAD), which
some people find annoying.

	Arnd
