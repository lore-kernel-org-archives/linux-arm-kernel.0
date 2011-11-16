From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 16 Nov 2011 08:42:58 +0000
Subject: Error for machine_is_m28evk
In-Reply-To: <20111116055939.GA11261@S2100-06.ap.freescale.net>
References: <CAOMZO5C4=ELWef8keoT8u0H8jTPRGQ5BA_8xYyKge++s+wdNqw@mail.gmail.com>
 <4EB8CC7B.5060503@denx.de> <20111108075349.GK2854@pengutronix.de>
 <CAB4PhKeKdGLa74W-n1DNbUcszWMf3nymqqhuzdZoj_oQG+YNsg@mail.gmail.com>
 <20111108085350.GX12913@n2100.arm.linux.org.uk>
 <20111108125346.GA7563@S2100-06.ap.freescale.net>
 <20111116055939.GA11261@S2100-06.ap.freescale.net>
Message-ID: <20111116084258.GF9581@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 16, 2011 at 01:59:41PM +0800, Shawn Guo wrote:
> Hi Russell,
> 
> On Tue, Nov 08, 2011 at 08:53:47PM +0800, Shawn Guo wrote:
> > On Tue, Nov 08, 2011 at 08:53:50AM +0000, Russell King - ARM Linux wrote:
> > [...]
> > > 
> > > Maybe the answer is to just update the file anyway, and ignore peoples
> > > complaints that their entries aren't present until they come to their
> > > senses and start COMMUNICATING properly about issues they have with
> > > their fscked up entry in the database.
> > > 
> > So I assume that you will update mach-types for -rc2.  Otherwise,
> > please let me know, and I will send a patch to disable m28evk build
> > from mxs_defconfig for -rc2.
> > 
> May I know your plan of mach-types updating?  The -rc2 is out with no
> update on mach-types.

There is *NO* bloody way I'm updating this *known* *build* *breaking*
thing in an -rc series.  I've already stated my reasons, and I _know_
it will break stuff.  I've pointed out what the changes are.  It's in
linux-next.  No one has responded to that.
