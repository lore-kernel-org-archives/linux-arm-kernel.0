From: andrew@aj.id.au (Andrew Jeffery)
Date: Tue, 11 Oct 2016 09:57:35 +1030
Subject: [PATCH 0/8] pinctrl: aspeed: Fixes for core and g5, implement
 remaining pins
In-Reply-To: <CACRpkdZWbx1_SYJMOn40teQaEw1JAq80kDAp7N+OYaMRRO6NBg@mail.gmail.com>
References: <cover.115463f791b69859c5ce9dafd61a5755ea039f4b.1474986045.git-series.andrew@aj.id.au>
 <CACRpkdZWbx1_SYJMOn40teQaEw1JAq80kDAp7N+OYaMRRO6NBg@mail.gmail.com>
Message-ID: <1476142055.16733.4.camel@aj.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2016-10-10 at 09:59 +0200, Linus Walleij wrote:
> On Tue, Sep 27, 2016 at 4:50 PM, Andrew Jeffery <andrew@aj.id.au> wrote:
> 
> > 
> > The initial Aspeed pinctrl patches implemented a subset of pins for each of the
> > g4 and g5 SoCs. This series provides a number of fixes to the initial patches,
> > mostly for issues identified in the g5 driver. The fixes account for the first
> > half of the series (up to and including "pinctrl: aspeed-g5: Fix pin
> > association of SPI1 function") and should be applied for 4.9.
> Those are applied for fixes.

Thanks!

> 
> > 
> > The second half, from "pinctrl: aspeed: Enable capture of off-SCU pinmux
> > state", implements some additional functionality in the core engine for the
> > Aspeed SoCs and follows up with patches implementing mux configuration tables
> > for all remaining pins. Given the significant additions in the last few
> > patches, their lateness in the cycle and the light testing they have received
> > they are best left for 4.10, but I'm keen to get them out for review.
> I'm holding these back until v4.9-rc1 is out.

No worries; they need some discussion when you have the time.

Cheers,

Andrew
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161011/339a02a0/attachment.sig>
