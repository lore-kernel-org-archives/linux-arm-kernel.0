From: andrew@aj.id.au (Andrew Jeffery)
Date: Fri, 21 Oct 2016 11:03:31 +1030
Subject: [PATCH 6/8] pinctrl: aspeed-g4: Capture SuperIO pinmux dependency
In-Reply-To: <CACRpkdYLDesENtq2cQBrWQeL6NH+mO_N5Z=e9=gsoZSCE85Jag@mail.gmail.com>
References: <cover.115463f791b69859c5ce9dafd61a5755ea039f4b.1474986045.git-series.andrew@aj.id.au>
 <b5f67ba76018314d08e240f95951751896687d37.1474986045.git-series.andrew@aj.id.au>
 <CACRpkdYLDesENtq2cQBrWQeL6NH+mO_N5Z=e9=gsoZSCE85Jag@mail.gmail.com>
Message-ID: <1477010011.8917.20.camel@aj.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Thu, 2016-10-20 at 13:53 +0200, Linus Walleij wrote:
> On Tue, Sep 27, 2016 at 4:50 PM, Andrew Jeffery <andrew@aj.id.au>
> wrote:
> 
> > 
> > Two LPC-related signals in the AST2400 depend on state in the
> > SuperIO IP
> > block. Use the recently added infrastructure to capture this
> > relationship.
> > 
> > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> Patch applied for v4.10.
> (Tell me if I'm applying patches in wrong order or something, and
> I hope this doesn't clash with the fixes.)

Both this patch and 8/8 functionally depend on 5/8. I fetched the
pinctrl tree to poke around but this patch didn't appear in any of the
updated branches, so I'm not sure whether we have the right ordering.
Without it we should hit build failures from missing macro definitions.

Have you had a chance to look over patch 5/8? Joel wasn't keen on its
current form, so I would appreciate your input.

Cheers,

Andrew

> 
> Yours,
> Linus Walleij
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161021/07de7adc/attachment.sig>
