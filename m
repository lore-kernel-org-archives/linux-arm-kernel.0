From: andrew@aj.id.au (Andrew Jeffery)
Date: Fri, 18 Nov 2016 10:11:41 +1030
Subject: [RFC PATCH] mfd: dt: Add Aspeed LPC binding
In-Reply-To: <CACRpkdazPEbU2gmDyke=GTYtjVp8aeauS+PVkp-zuiVoVz7kbw@mail.gmail.com>
References: <20161117060633.3837-1-andrew@aj.id.au>
 <CACRpkdazPEbU2gmDyke=GTYtjVp8aeauS+PVkp-zuiVoVz7kbw@mail.gmail.com>
Message-ID: <1479426101.5215.13.camel@aj.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2016-11-17 at 10:30 +0100, Linus Walleij wrote:
> > On Thu, Nov 17, 2016 at 7:06 AM, Andrew Jeffery <andrew@aj.id.au> wrote:
> 
> > +* Device tree bindings for the Aspeed LPC Controller
> 
> We are going overboard with the lingo sometimes, to the point that we do not
> understand how terse things become.

Sorry for that, it is a bit terse. Sometimes I struggle to gauge how
much context I should provide.

Joel's reply covers the details of your queries below, but I'll make
sure to add the information to the bindings as well.

> 
> LPC = Low Pin Count, right?
> Explain that right here: it is a slow external bus, right?

> > +The Aspeed LPC controller contains registers for a variety of functions. Not
> > +all registers for a function are contiguous, and some registers are referenced
> > +by functions outside the LPC controller.
> > +
> > +Note that this is separate from the H8S/2168 compatible register set occupying
> > +the start of the LPC controller address space.
> > +
> > +Some significant functions in the LPC controller:
> > +
> > +* LPC Host Controller
> > +* Host Interface Controller
> 
> Host interface to what?
> 
> > +* iBT Controller
> 
> What is iBT?
> 
> > +* SuperIO Scratch registers
> 
> Again more context please.
> 
> With standards documents, either explain everything or provide
> pointers for the information.

ACK!

Andrew
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161118/4fa39301/attachment-0001.sig>
