From: olof@lixom.net (Olof Johansson)
Date: Fri, 22 Aug 2014 23:25:13 -0700
Subject: [PATCH] ARM: mvebu: update v7 defconfig with useful options
In-Reply-To: <20140822175308.GZ12769@titan.lakedaemon.net>
References: <1408729202-11064-1-git-send-email-olof@lixom.net>
 <20140822175308.GZ12769@titan.lakedaemon.net>
Message-ID: <20140823062513.GA23715@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 22, 2014 at 01:53:08PM -0400, Jason Cooper wrote:
> Olof,
> 
> On Fri, Aug 22, 2014 at 10:40:02AM -0700, Olof Johansson wrote:
> > Turn on a bunch of options to make my cubox bootable/usable:
> > 
> > PRINTK_TIME
> > EXT4 (and turn off 2/3 since 4 can mount all filesystems)
> > MV643XX_ETH for Dove
> > SDHCI for Dove
> > DEVTMPFS
> > PACKET and UNIX protocol support
> > 
> > Much of the other churn is just due to reorderings in the defconfig
> > 
> > Signed-off-by: Olof Johansson <olof@lixom.net>
> > ---
> >  arch/arm/configs/mvebu_v7_defconfig |   67 ++++++++++++++++-------------------
> >  1 file changed, 31 insertions(+), 36 deletions(-)
> 
> Applied to mvebu/defconfig.  It'll be in -next for Stephen's next run
> (Sunday night, hopefully).

Ok, cool. I can't start testing it until it hits mainline, since the
DTBs are built but the config options aren't there on the kernel, so
it'll just keep failing for several weeks. I'll revisit once 3.18 merge
window is open though -- it's not a huge deal to miss out on this until
then IMHO so we can keep it for next merge window.


-Olof
