From: jamie@jamieiles.com (Jamie Iles)
Date: Mon, 24 Oct 2011 12:00:15 +0100
Subject: [PATCH v2 1/5] ARM: SPMP8000: Add machine base files
In-Reply-To: <201110241113.21837.arnd@arndb.de>
References: <1318178172-7965-1-git-send-email-zoss@devai.org>
	<1409922.Ostx0EbfK3@wuerfel>
	<CAGVye5PR3rDbGOf48sPtnZHJXPCa_eY1JqeUZKyeLGk4s_LNHA@mail.gmail.com>
	<201110241113.21837.arnd@arndb.de>
Message-ID: <20111024110015.GA5212@totoro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Mon, Oct 24, 2011 at 11:13:21AM +0200, Arnd Bergmann wrote:
> On Sunday 23 October 2011, Zoltan Devai wrote:
> > 2011/10/19 Arnd Bergmann <arnd@arndb.de>:
> > > On Wednesday 19 October 2011 18:01:54 Zoltan Devai wrote:
> > >> Files needed for the basic machine support of SPMP8000
> > >>
> > >> Signed-off-by: Zoltan Devai <zoss@devai.org>
> > >
> > > Hi Zoltan,
> > >
> > > This version looks very nice, only a few small things remain that I noticed
> > > reading through it again:
> > OK, will correct these.
> > 
> > What's next then ?
> 
> We talked about it at the ARM subarchitecture maintainer summit, and I think
> I'll just merge your platform code for 3.2 if you send the fixed version
> in time. I'm not going to merge your clk support patch (2/5) though, since

Zoltan uses my device tree bindings and multi IRQ handler for the VIC 
which hasn't yet been merged (and I haven't had any 
Tested-by/Acked-by's) from anyone other than Zoltan yet.

I suppose the device tree binding and multi IRQ handler patches /could/ 
go in without the other platform conversions though they haven't had any 
time in -next.

Jamie
