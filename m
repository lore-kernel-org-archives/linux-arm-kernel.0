From: kevin.wells@nxp.com (Kevin Wells)
Date: Thu, 28 Jan 2010 20:51:39 +0100
Subject: [PATCH 08/13] ARM: LPC32XX: clock tree support
In-Reply-To: <20100128170728.GA14674@debian>
References: <1264643011-17390-1-git-send-email-wellsk40@gmail.com>
	<1264643011-17390-9-git-send-email-wellsk40@gmail.com>
	<20100128170728.GA14674@debian>
Message-ID: <083DF309106F364B939360100EC290F805C8A0A7F5@eu1rdcrdc1wx030.exi.nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > +static struct clk_lookup lookups[] __initdata = {
> 
> This shouldn't be __initdata, since it'll be needed when loading modules
> which use clk_get().
> 

Nice catch - I'll fix this.
