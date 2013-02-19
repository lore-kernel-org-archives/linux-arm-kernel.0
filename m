From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 19 Feb 2013 16:15:40 +0000
Subject: [PATCH] ARM: dove: update dove_defconfig with a few useful options
In-Reply-To: <20130123151530.GU1758@titan.lakedaemon.net>
References: <1358099647-22323-1-git-send-email-olof@lixom.net>
 <20130123151530.GU1758@titan.lakedaemon.net>
Message-ID: <201302191615.40971.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 23 January 2013, Jason Cooper wrote:
> On Sun, Jan 13, 2013 at 09:54:07AM -0800, Olof Johansson wrote:
> > This refreshes the dove_defconfig, and adds:
> > PRINTK_TIME
> > DEVTMPFS
> > EXT4
> > 
> > They're quite useful, and allows booting a cubox ubuntu rootfs on SD card,
> > since that by default uses ext4.
> > 
> > The rest of the churn is due to options and defaults moving around, no
> > functional difference.
> > 
> > Signed-off-by: Olof Johansson <olof@lixom.net>
> > Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> > 
> > ---
> >  arch/arm/configs/dove_defconfig | 28 ++++++++--------------------
> >  1 file changed, 8 insertions(+), 20 deletions(-)
> 
> Applied to mvebu/boards

Hi Olof,

I've just tried rebuilding the for-next branch, which turned out very
easy this time, but this one patch is what stuck out: apparently
you had already applied it into for-next, but it is not on
any of the other branches. Do you know what is going on here?

	Arnd
