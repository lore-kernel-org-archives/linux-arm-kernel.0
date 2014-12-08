From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 08 Dec 2014 14:28:44 +0100
Subject: linux-next: manual merge of the bcm2835 tree with the arm-soc tree
In-Reply-To: <20141208130009.GL3951@x1>
References: <20141208120619.68287b54@canb.auug.org.au>
 <2406890.FlzRjyvuXd@wuerfel> <20141208130009.GL3951@x1>
Message-ID: <3348703.0b5FTH9Sa3@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 08 December 2014 13:00:09 Lee Jones wrote:
> On Mon, 08 Dec 2014, Arnd Bergmann wrote:
> 
> > On Monday 08 December 2014 12:06:19 Stephen Rothwell wrote:
> > > Hi Stephen,
> > > 
> > > Today's linux-next merge of the bcm2835 tree got a conflict in
> > > arch/arm/boot/dts/Makefile between commit 302a5ef29d49 ("ARM: BCM5301X:
> > > Add DT for Netgear R6300 V2") from the arm-soc tree and commit
> > > 6298ed17a404 ("ARM: bcm2835: Add device tree for Raspberry Pi model
> > > B+") from the bcm2835 tree.
> > > 
> > > I fixed it up (the bcm2835 tree patch is also in the arm-soc tree as
> > > commit ba2a1d6959ac ("ARM: bcm2835: Add device tree for Raspberry Pi
> > > model B+"), so I just used the arm-soc version) and can carry the fix
> > > as necessary (no action is required).
> > 
> > Thanks a lot for the notification!
> > 
> > Lee, do you know what is going on? Did you accidentally rebase a commit
> > that you already sent for inclusion in arm-soc?
> 
> Nope.  The branch hasn't changed at all.
> 
> OOI why would a re-base affect anything?  I sent you it in patch form.

Ah, I looked at the wrong branch and didn't see that I applied a patch
instead of a pull request. It's all fine then, as long as you never
intend to send any pull requests based on top of your current branch.

You can possibly make Stephen's life a tiny bit simpler if you just
drop all patches from your for-next branch as soon as we've picked
them up into arm-soc.

	Arnd
