From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 11 Jun 2013 17:02:35 +0200
Subject: [PATCH 04/14] bus: mvebu-mbus: Add static window allocation to
 the DT binding
In-Reply-To: <20130611133143.GB3996@localhost>
References: <1370623671-7748-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <201306072101.44694.arnd@arndb.de> <20130611133143.GB3996@localhost>
Message-ID: <5585884.5SuYAUWeyv@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 11 June 2013 10:31:45 Ezequiel Garcia wrote:
> > > +
> > > +   soc {
> > > +           bootrom {
> > > +                   ranges = <0 0x01e00000 0xfff00000 0x100000>;
> > > +           };
> > > +   };
> > 
> > I think I'm a bit lost here. Is the "soc" node in this example the node
> > that is described as compatible="marvell,armada370-mbus"? Maybe expand
> > the example a little here to clarify this.
> > 
> 
> Exactly: that's the mbus-compatible node. I'll clarify a bit the documentation
> so this is clearer.
> 
> I kept the 'soc' name in the examples as that's the name in the dts files. 
> Do you think I should rename to 'mbus' in the dts files?
> 
> I haven't done that since that would imply to change all the dts
> files.

The name of the device node is not very important, so you can leave
it alone if it causes problems, or change it something else if you
find it more appropriate.

	Arnd
