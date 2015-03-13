From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 13 Mar 2015 17:52:39 +0100
Subject: [PATCH] MAINTAINERS: Add myself as co-maintainer to the legacy
 support of the mvebu SoCs
In-Reply-To: <20150313161511.GE7311@lunn.ch>
References: <1426254105-28649-1-git-send-email-gregory.clement@free-electrons.com>
 <49808502.FHjQOLPYaI@wuerfel> <20150313161511.GE7311@lunn.ch>
Message-ID: <10396055.aDQnxkV0zV@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 13 March 2015 17:15:11 Andrew Lunn wrote:
> On Fri, Mar 13, 2015 at 04:24:57PM +0100, Arnd Bergmann wrote:
> > On Friday 13 March 2015 14:40:16 Andrew Lunn wrote:
> > > On Fri, Mar 13, 2015 at 02:41:45PM +0100, Gregory CLEMENT wrote:
> > > > I will also take care of the legacy support(not fully converted to DT)
> > > > of the mvebu SoCs.
> > > > 
> > > > Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> > > > ---
> > > >  MAINTAINERS | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > > 
> > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > index ddc5a8cf9a8a..39b27f52e217 100644
> > > > --- a/MAINTAINERS
> > > > +++ b/MAINTAINERS
> > > > @@ -1188,6 +1188,7 @@ ARM/Marvell Dove/MV78xx0/Orion SOC support
> > > >  M:   Jason Cooper <jason@lakedaemon.net>
> > > >  M:   Andrew Lunn <andrew@lunn.ch>
> > > >  M:   Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> > > > +M:   Gregory Clement <gregory.clement@free-electrons.com>
> > > >  L:   linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
> > > >  S:   Maintained
> > > >  F:   arch/arm/mach-dove/
> > > 
> > > Acked-by: Andrew Lunn <andrew@lunn.ch>
> > > 
> > 
> > Should we pick this up for the 4.0 fixes branch directly?
> 
> Hi Arnd
> 
> Is it a fix?
> 
> I don't really care either way.

I think it should be in 4.0-rc in order to get people to Cc you on
patches, so I consider it a fix. My question was more about how
it gets there: whether I pick it up first, or one of you sends a
pull request for mvebu fixes.

	Arnd
