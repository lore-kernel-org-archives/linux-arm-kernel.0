From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 13 Oct 2015 23:09:32 +0800
Subject: [PATCH 00/37] ARM: dts: Fix fixed regulators enable GPIO polarity
In-Reply-To: <1561402.NmbcA6rYT5@avalon>
References: <1444684386-17094-1-git-send-email-laurent.pinchart@ideasonboard.com>
 <20151013140946.GB584@tiger> <1561402.NmbcA6rYT5@avalon>
Message-ID: <20151013150932.GD584@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 13, 2015 at 05:17:24PM +0300, Laurent Pinchart wrote:
> Hi Shawn,
> 
> On Tuesday 13 October 2015 22:09:46 Shawn Guo wrote:
> > On Tue, Oct 13, 2015 at 12:12:29AM +0300, Laurent Pinchart wrote:
> > > Laurent Pinchart (37):
> > ...
> > 
> > >   ARM: imx6sx-sdb: Fix typo in regulator enable GPIO property
> > 
> > ...
> > 
> > >   ARM: dts: imx6qdl-tx6: Fix regulator enable GPIO polarity
> > 
> > ...
> > 
> > >   ARM: dts: imx23-evk: Fix regulator enable GPIO polarity
> > >   ARM: dts: imx23-stmp378x_devb: Fix regulator enable GPIO polarity
> > >   ARM: dts: imx25-pdk: Fix regulator enable GPIO polarity
> > >   ARM: dts: imx28-cfa10036: Fix regulator enable GPIO polarity
> > >   ARM: dts: imx28-evk: Fix regulator enable GPIO polarity
> > >   ARM: dts: imx28-m28cu3: Fix regulator enable GPIO polarity
> > >   ARM: dts: imx28-m28evk: Fix regulator enable GPIO polarity
> > >   ARM: dts: imx28-sps1: Fix regulator enable GPIO polarity
> > >   ARM: dts: imx28-tx28: Fix regulator enable GPIO polarity
> > >   ARM: dts: imx53-m53evk: Fix regulator enable GPIO polarity
> > >   ARM: dts: imx53-mba53: Fix regulator enable GPIO polarity
> > >   ARM: dts: imx53-tx53: Fix regulator enable GPIO polarity
> > >   ARM: dts: imx6q-dmo-edmqmx6: Fix regulator enable GPIO polarity
> > 
> > Applied these 15 patches, thanks.
> 
> There's ongoing discussions regarding whether this is the right thing to do. 
> Please see http://www.spinics.net/lists/arm-kernel/msg451724.html. It's thus a 
> bit early to apply the patches at this point I'm afraid.

Okay, dropped them except the first one which fixes a typo for
imx6sx-sdb.

Shawn
