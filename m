From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed, 4 Apr 2012 19:48:28 +0200
Subject: [PATCH] clkdev: Implement managed clk_get()
In-Reply-To: <20120402215927.GG3160@opensource.wolfsonmicro.com>
References: <1333403385-24133-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <20120402215341.GL24211@n2100.arm.linux.org.uk>
 <20120402215927.GG3160@opensource.wolfsonmicro.com>
Message-ID: <20120404174828.GA27171@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Mark Brown wrote:
> On Mon, Apr 02, 2012 at 10:53:41PM +0100, Russell King - ARM Linux wrote:
> > On Mon, Apr 02, 2012 at 10:49:45PM +0100, Mark Brown wrote:
> 
> > > +CLOCK
> > > +  devm_clk_get()
> 
> > devm_clk_put() ?
> 
> Yeah, I noticed that immediately after I sent when it turned up in my
> inbox and have already fixed locally - it'll be in any future version
> I send out.

The kerneldoc comment for devm_clk_put() also needs updating in case you
haven't fixed it already.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120404/3a417da3/attachment.sig>
