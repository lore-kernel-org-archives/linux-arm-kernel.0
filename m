From: marek.vasut@gmail.com (Marek Vasut)
Date: Fri, 27 Nov 2009 02:49:24 +0100
Subject: [PATCH 1/3] ARM: pxa/raumfeld: add platform support
In-Reply-To: <20091126221929.GB8756@n2100.arm.linux.org.uk>
References: <1259258341-31114-1-git-send-email-daniel@caiaq.de>
	<200911262311.26533.marek.vasut@gmail.com>
	<20091126221929.GB8756@n2100.arm.linux.org.uk>
Message-ID: <200911270249.24357.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne ?t 26. listopadu 2009 23:19:30 Russell King - ARM Linux napsal(a):
> On Thu, Nov 26, 2009 at 11:11:26PM +0100, Marek Vasut wrote:
> > Dne ?t 26. listopadu 2009 20:18:40 Russell King - ARM Linux napsal(a):
> > > On Thu, Nov 26, 2009 at 08:13:47PM +0100, Marek Vasut wrote:
> > > > Why don't we separate the common MFP configuration into another table
> > > > as some platforms do ? The code duplication is horrible here ...
> > >
> > > Please read the comments on the previous patch series for this.
> >
> > So is it your preference or is there any valid argument to support your
> > way ?
> 
> The original way was to have many small tables setting up the MFP
> according to which devices were going to be registered.

Yeah, that's weird.
> 
> Mike suggested to have one common table and a per-board table, but the
> response was that this could lead to duplications and other similar
> problems.

Why duplications ? One common table (it's obvious which pins would be there) and 
3 small tables containing the rest would be nice.
> 
> So I suggested the obvious alternative solution which solves all the
> stated issues.

And actually does a duplication.
> 
> So not really a preference nor supported by a pressing reason.  Merely
> just a solution which makes all the currently stated issues go away.
> 
Really ...
