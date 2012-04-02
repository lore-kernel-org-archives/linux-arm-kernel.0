From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 2 Apr 2012 22:59:28 +0100
Subject: [PATCH] clkdev: Implement managed clk_get()
In-Reply-To: <20120402215341.GL24211@n2100.arm.linux.org.uk>
References: <1333403385-24133-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <20120402215341.GL24211@n2100.arm.linux.org.uk>
Message-ID: <20120402215927.GG3160@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 02, 2012 at 10:53:41PM +0100, Russell King - ARM Linux wrote:
> On Mon, Apr 02, 2012 at 10:49:45PM +0100, Mark Brown wrote:

> > +CLOCK
> > +  devm_clk_get()

> devm_clk_put() ?

Yeah, I noticed that immediately after I sent when it turned up in my
inbox and have already fixed locally - it'll be in any future version
I send out.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120402/60805c4e/attachment.sig>
