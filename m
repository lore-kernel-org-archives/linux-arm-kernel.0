From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 18 Apr 2016 21:28:35 +0200
Subject: [PATCH 2/2] ARM: multi_v5_defconfig: Enable recommended options
 for systemd
In-Reply-To: <20160412142654.GA24304@tiger>
References: <1458991706-30109-1-git-send-email-jlu@pengutronix.de>
 <1460462268.2629.27.camel@pengutronix.de> <20160412142654.GA24304@tiger>
Message-ID: <5243175.i5zkJhBvDK@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 12 April 2016 22:26:54 Shawn Guo wrote:
> On Tue, Apr 12, 2016 at 01:57:48PM +0200, Jan L?bbe wrote:
> > On Sa, 2016-03-26 at 12:28 +0100, Jan Luebbe wrote:
> > > Enable FHANDLE, CGROUPS, BLK_DEV_BSG and DEVTMPFS as recommended by
> > > systemd (which also matches the multi_v7 defconfig). Also enable IPV6,
> > > which defaults to 'y' by now.
> > > 
> > > Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
> > 
> > Shawn, you've already applied 1/2. Do you have any concerns or comments
> > regarding this one?
> 
> I thought that Arnd's request and Sascha's ACK only applies to 1/2.
> Just applied 2/2 as well.  @Arnd, let me know if I shouldn't.
> 
> 

I'd like to see both get picked up into the same branch if the changes are
for the same platform, sorry if that wasn't clear enough.

I guess in this case you can argue that the actual changes of 2/2 are
not imx specific at all, and I'd be fine with picking them up directly,
but I tend to prefer the defconfig changes to come from one of the subarch
maintainers just so I don't have to watch too carefully for patches
on the mailing list.

	Arnd
